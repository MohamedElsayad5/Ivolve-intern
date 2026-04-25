# 📘 Lab 11: Namespace Management and Resource Quota Enforcement in Kubernetes

## 🎯 Objective
This lab demonstrates how to:
- Create a Kubernetes namespace
- Apply ResourceQuota to limit number of pods inside the namespace

---

## 🧱 Environment
- Kubernetes Cluster (Minikube)
- kubectl configured

---

## 🚀 Step 1: Create Namespace

```bash
kubectl create namespace ivolve
```

### Output:
```text
namespace/ivolve created
```

---

## 📦 Step 2: Create ResourceQuota

Create file `quota.yaml`:

```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: pod-limit
  namespace: ivolve
spec:
  hard:
    pods: "2"
```

Apply it:

```bash
kubectl apply -f quota.yaml
```

### Output:
```text
resourcequota/pod-limit created
```

---

## 🔍 Step 3: Verify ResourceQuota

```bash
kubectl get resourcequota -n ivolve
```

### Output:
```text
NAME        REQUEST     LIMIT   AGE
pod-limit   pods: 0/2           10s
```

```bash
kubectl describe resourcequota pod-limit -n ivolve
```

### Output:
```text
Name:       pod-limit
Namespace:  ivolve
Resource    Used  Hard
--------    ----  ----
pods        0     2
```

---

## 🧪 Step 4: Test Pod Creation

```bash
kubectl run test1 --image=nginx -n ivolve
kubectl run test2 --image=nginx -n ivolve
```

### Output:
```text
pod/test1 created
pod/test2 created
```

---

## ❌ Step 5: Exceed Limit Test

```bash
kubectl run test3 --image=nginx -n ivolve
```

### Output:
```text
Error from server (Forbidden): pods "test3" is forbidden: exceeded quota: pod-limit, requested: pods=1, used: pods=2, limited: pods=2
```

---

## 🧠 Key Concepts

- Namespace → Logical isolation in Kubernetes
- ResourceQuota → Limits resources inside a namespace
- pods: "2" → Maximum allowed pods

---

## 🔐 Result

✔ Namespace created: ivolve  
✔ Resource quota applied  
✔ Pod limit enforced (2 pods max)  
✔ Third pod blocked successfully  

---

## 👨‍💻 Author
Mohamed Mahmoud Mohamed Fayed Elsayed
