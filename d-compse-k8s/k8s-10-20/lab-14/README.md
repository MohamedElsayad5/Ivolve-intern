# 📘 Lab 14: StatefulSet with Headless Service (MySQL)

## 🎯 Objective
This lab demonstrates how to:
- Deploy a StatefulSet running MySQL
- Use Secrets for sensitive data (root password)
- Attach Persistent Volume for database storage
- Create a Headless Service for stable network identity
- Add tolerations for node scheduling
- Verify MySQL connectivity

---

## 🧱 Environment
- Kubernetes Cluster (Minikube)
- kubectl configured
- Docker driver

---

## 📁 Step 1: Create Lab Directory & YAML Files

```bash
mkdir lab-14
cd lab-14

nano mysql-secret.yaml
nano mysql-service.yaml
nano mysql-pvc.yaml
nano mysql-statefulset.yaml
```

---

## 🔐 Step 2: Apply Kubernetes Resources

```bash
kubectl apply -f mysql-secret.yaml
kubectl apply -f mysql-service.yaml
kubectl apply -f mysql-pvc.yaml
kubectl apply -f mysql-statefulset.yaml
```

### Output:
```text
secret/mysql-secret created
service/mysql-headless created
persistentvolumeclaim/mysql-pvc created
statefulset.apps/mysql created
```

---

## 📦 Step 3: Check Pods Status

```bash
kubectl get pods
```

### Output (initial state):
```text
mysql-0   0/1   ContainerCreating
```

### After fix:
```text
mysql-0   1/1   Running
```

---

## 🔍 Step 4: Check StatefulSet & Service

```bash
kubectl get statefulset
kubectl get svc
```

### Output:
```text
NAME    READY   AGE
mysql   0/1     <age>

NAME             TYPE        CLUSTER-IP   PORT(S)
mysql-headless   ClusterIP   None         3306/TCP
```

---

## 💾 Step 5: Check PVC

```bash
kubectl get pvc
```

### Output:
```text
mysql-pvc               Bound
mysql-storage-mysql-0   Bound
```

---

## ❌ Step 6: Common Error (Connection Issue)

```bash
kubectl exec -it mysql-0 -- mysql -uroot -p
```

### Error:
```text
ERROR 1045 (28000): Access denied for user 'root'
```

---

## 🔑 Step 7: Get MySQL Password

```bash
kubectl get secret mysql-secret -o yaml
```

### Encoded value:
```text
MYSQL_ROOT_PASSWORD: bXlzcWwtcGFzc3dvcmQ=
```

### Decode it:
```bash
echo "bXlzcWwtcGFzc3dvcmQ=" | base64 --decode
```

### Result:
```text
mysql-password
```

---

## 🧹 Step 8: Fix (Clean Redeploy)

```bash
kubectl delete statefulset mysql
kubectl delete svc mysql-headless
kubectl delete pvc mysql-storage-mysql-0 mysql-pvc
```

Then re-apply:

```bash
kubectl apply -f mysql-secret.yaml
kubectl apply -f mysql-service.yaml
kubectl apply -f mysql-pvc.yaml
kubectl apply -f mysql-statefulset.yaml
```

---

## 🟢 Step 9: Final Running State

```bash
kubectl get pods -w
```

### Output:
```text
mysql-0   1/1   Running
```

---

## 🧪 Step 10: Connect to MySQL

```bash
kubectl exec -it mysql-0 -- mysql -uroot -pmysql-password
```

### Success Output:
```text
Welcome to the MySQL monitor
mysql>
```

---

## 🧠 Key Concepts

- **StatefulSet** → stable identity + persistent storage
- **Headless Service** → DNS-based pod discovery
- **Secret** → secure password storage (base64 encoded)
- **PVC** → persistent database storage
- **Toleration** → allows scheduling on tainted nodes

---

## ⚠️ Important Notes

- PVC keeps MySQL data permanently
- Secret changes do NOT reset MySQL password
- First initialization defines root password
- Correct password used: `mysql-password`

---

## 👨‍💻 Author
Mohamed Mahmoud Mohamed Fayed Elsayed
