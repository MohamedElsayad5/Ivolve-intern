# 🧪 Lab 19: Node-Wide Pod Management with DaemonSet

## 📌 Objective
Deploy a **DaemonSet (Prometheus node-exporter)** to ensure that a monitoring agent runs on every node in the cluster and exposes system metrics on port **9100**.

---

## 📁 Step 1: Create Working Directory
mkdir lab-19
cd lab-19

---

## 📦 Step 2: Create Monitoring Namespace

kubectl create namespace monitoring

✔ Output:
namespace/monitoring created

---

## ⚙️ Step 3: Create DaemonSet Manifest

nano node-exporter.yaml

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: node-exporter
  namespace: monitoring
spec:
  selector:
    matchLabels:
      app: node-exporter
  template:
    metadata:
      labels:
        app: node-exporter
    spec:
      tolerations:
        - operator: "Exists"
      containers:
        - name: node-exporter
          image: prom/node-exporter
          ports:
            - containerPort: 9100
