# 📘 Lab 13: Persistent Storage Setup for Application Logging

## 🎯 Objective
This lab demonstrates how to:
- Create a Persistent Volume (PV)
- Create a Persistent Volume Claim (PVC)
- Bind PV and PVC together
- Use hostPath storage in Kubernetes

---

## 🧱 Environment
- Kubernetes Cluster (Minikube)
- kubectl configured
- Node storage using /mnt directory

---

## 📁 Step 1: Create Lab Directory

```bash
mkdir lab-13
cd lab-13
```

---

## 📄 Step 2: Create Persistent Volume (PV)

Create file `pv.yaml`

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: app-pv
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain
  storageClassName: manual
  hostPath:
    path: /mnt/app-logs
```

---

## 📄 Step 3: Create Persistent Volume Claim (PVC)

Create file `pvc.yaml`

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: app-pvc
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 1Gi
  storageClassName: manual
```

---

## 🚀 Step 4: Apply Resources

```bash
kubectl apply -f pv.yaml
kubectl apply -f pvc.yaml
```

### Output:

```text
persistentvolume/app-pv created
persistentvolumeclaim/app-pvc created
```

---

## 🔍 Step 5: Verify PV & PVC

```bash
kubectl get pv
kubectl get pvc
```

### Output:

```text
NAME     CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM             STORAGECLASS   AGE
app-pv   1Gi        RWX            Retain           Bound    default/app-pvc   manual         12s

NAME      STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
app-pvc   Bound    app-pv   1Gi        RWX            manual         12s
```

---

## 🧠 Step 6: Verify HostPath on Node

```bash
minikube ssh
ls /mnt
```

---

## 🧠 Key Concepts

- Persistent Volume (PV) → Physical storage in cluster
- Persistent Volume Claim (PVC) → Request for storage
- hostPath → Local node filesystem storage
- ReadWriteMany → Multiple pods can access storage
- Retain → Data preserved after PVC deletion

---

## ⚠️ Observations

- PV created successfully
- PVC successfully bound to PV
- Storage class matched correctly
- Volume status is Bound → ready for use

---

## 👨‍💻 Author

Mohamed Mahmoud Mohamed Fayed Elsayed
