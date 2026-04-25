Kubernetes Labs (Lab 16 & Lab 17)
copying the files from lab-16 to use it in lab-17

🧾 Step 2: Create Kubernetes Manifests
nano configmap.yaml
nano secret.yaml
nano deployment.yaml
nano service.yaml

⚙️ Step 3: Apply Resources
kubectl apply -f ./

Output:
nodejs-app created
mysql secret created
service created
configmap created

🔍 Step 4: Verify Resources
kubectl get pods -n ivolve
kubectl get deploy -n ivolve
kubectl get svc -n ivolve

⚠️ Issues Observed
Node scheduling issues (taints)
Resource quota limits
Init container dependency on MySQL

🧠 Key Concepts
Deployment manages app replicas
ConfigMap stores configuration
Secret stores credentials
Init Container prepares database before app starts
ClusterIP provides internal networking

🧪 Lab 17: Resource Management + Full Fix

📌 Objective
Add CPU & Memory requests and limits
Fix database connectivity
Deploy MySQL properly
Ensure full application running state

⚙️ Step 1: MySQL Deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql
  namespace: ivolve
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mysql
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
        - name: mysql
          image: mysql:5.7
          env:
            - name: MYSQL_ROOT_PASSWORD
              value: root
          ports:
            - containerPort: 3306

⚙️ Step 2: NodeJS Deployment (Final Fixed Version)
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nodejs-app
  namespace: ivolve
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nodejs-app

  template:
    metadata:
      labels:
        app: nodejs-app

    spec:
      tolerations:
        - key: node
          operator: Equal
          value: worker
          effect: NoSchedule

      initContainers:
        - name: db-init
          image: mysql:5.7
          env:
            - name: DB_HOST
              valueFrom:
                configMapKeyRef:
                  name: nodejs-config
                  key: DB_HOST
            - name: MYSQL_ROOT_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: nodejs-secret
                  key: MYSQL_ROOT_PASSWORD
          command:
            - sh
            - -c
            - |
              echo "Waiting for MySQL...";
              until mysql -h $DB_HOST -uroot -p$MYSQL_ROOT_PASSWORD -e "SELECT 1"; do
                echo "MySQL not ready, retrying...";
                sleep 5;
              done;

              echo "Creating database...";
              mysql -h $DB_HOST -uroot -p$MYSQL_ROOT_PASSWORD -e "
              CREATE DATABASE IF NOT EXISTS ivolve;
              CREATE USER IF NOT EXISTS 'app_user'@'%' IDENTIFIED BY 'password';
              GRANT ALL PRIVILEGES ON ivolve.* TO 'app_user'@'%';
              FLUSH PRIVILEGES;
              ";

      containers:
        - name: nodejs-app
          image: moeyelsayad777/node-app:latest
          ports:
            - containerPort: 3000

          resources:
            requests:
              cpu: 200m
              memory: 256Mi
            limits:
              cpu: 500m
              memory: 512Mi

          env:
            - name: DB_HOST
              valueFrom:
                configMapKeyRef:
                  name: nodejs-config
                  key: DB_HOST
            - name: DB_NAME
              valueFrom:
                configMapKeyRef:
                  name: nodejs-config
                  key: DB_NAME
            - name: DB_USER
              valueFrom:
                secretKeyRef:
                  name: nodejs-secret
                  key: DB_USER
            - name: DB_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: nodejs-secret
                  key: DB_PASSWORD

🚀 Step 3: Apply Everything
kubectl apply -f mysql.yaml
kubectl apply -f deployment.yaml
kubectl apply -f configmap.yaml

🔍 Step 4: Verify
kubectl get pods -n ivolve
kubectl describe pod <pod-name> -n ivolve
kubectl logs <pod-name> -c db-init -n ivolve

📊 Final Result
MySQL: Running
NodeJS App: Running
Init Container: Completed successfully
Database initialized automatically

🧠 Key Learnings
Init Containers for dependency setup
Kubernetes DNS service discovery
Resource requests and limits
Debugging ImagePullBackOff issues
Handling ResourceQuota constraints

👨‍💻 Author
Mohamed Mahmoud Mohamed Fayed Elsayed