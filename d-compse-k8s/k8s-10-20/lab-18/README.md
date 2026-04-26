# 🧪 Lab 18: Control Pod-to-Pod Traffic using NetworkPolicy

## 📌 Objective
In this lab, we implement Kubernetes NetworkPolicy to control traffic between application pods and MySQL database.  
The goal is to restrict access so that only application pods can access MySQL on port 3306.

---

## 🏗️ Architecture
- NodeJS Application Pod  
- MySQL Database Pod  
- Kubernetes ClusterIP Services  
- NetworkPolicy for traffic restriction  
- Init Container for database initialization  

---

## 📂 Project Structure
lab-18/
├── configmap.yaml
├── secret.yaml
├── mysql.yaml
├── deployment.yaml
├── service.yaml
├── networkpolicy.yaml

---

## ⚙️ Step 1: Create Namespace
kubectl create namespace ivolve

---

## ⚙️ Step 2: Apply All Resources
kubectl apply -f . -n ivolve

✔ Output:
configmap/nodejs-config created  
secret/nodejs-secret created  
deployment.apps/mysql created  
deployment.apps/nodejs-app created  
service/mysql created  
service/nodejs-service created  
networkpolicy.networking.k8s.io/allow-app-to-mysql created  

---

## 📡 Step 3: Verify Resources
kubectl get pods -n ivolve
kubectl get svc -n ivolve
kubectl get networkpolicy -n ivolve

---

## 🧠 NetworkPolicy Configuration
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-app-to-mysql
  namespace: ivolve
spec:
  podSelector:
    matchLabels:
      app: mysql
  policyTypes:
    - Ingress
  ingress:
    - from:
        - podSelector:
            matchLabels:
              app: nodejs-app
      ports:
        - protocol: TCP
          port: 3306

---

## 🐬 MySQL Deployment
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

---

## 🚀 NodeJS App (with Init Container)
- Waits for MySQL to be ready  
- Creates database and user automatically  
- Uses ConfigMap + Secret for configuration  

---

## 🔍 Testing Connectivity

### MySQL Client Test
kubectl run mysql-client -it --rm -n ivolve --image=mysql:5.7 -- sh
mysql -h mysql -u app_user -ppassword

✔ Result:
Welcome to the MySQL monitor

---

### Network Test
kubectl run test -it --rm -n ivolve --image=busybox -- sh
wget mysql:3306

✔ Result:
Connected successfully to MySQL service

---

## ⚠️ Issues Faced & Fixes

### ❌ Namespace not found
✔ Fix:
kubectl create namespace ivolve

---

### ❌ ImagePullBackOff
✔ Fix:
Use correct image:
moeyelsayad777/node-app:latest

---

### ❌ MySQL DNS error
✔ Fix:
Use service name:
mysql

---

### ❌ NetworkPolicy blocking traffic
✔ Fix:
Allow only:
app=nodejs-app → mysql:3306

---

## 🧠 Key Learnings

- NetworkPolicy controls pod-to-pod communication
- Kubernetes DNS uses service name as hostname
- InitContainers handle dependency setup
- ClusterIP enables internal cluster networking
- Labels are critical for routing and policies

---

## 🎯 Final Result

✔ MySQL Running  
✔ NodeJS Running  
✔ NetworkPolicy Active  
✔ Database connection successful  
✔ Full pod-to-pod communication working  

---

## 👨‍💻 Author
Mohamed Mahmoud Mohamed Fayed Elsayed
