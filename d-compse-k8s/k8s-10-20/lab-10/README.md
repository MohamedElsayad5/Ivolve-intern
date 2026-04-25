# 📘 Lab 10: Node Isolation Using Taints in Kubernetes

## 🎯 Objective
This lab demonstrates how to isolate a Kubernetes node using **Taints**, so that only pods with matching tolerations can be scheduled on it.

---

## 🧱 Environment
- Kubernetes Cluster (Minikube)
- 1 Control Plane Node
- kubectl configured

---

## ⚙️ Step 1: Verify Cluster Nodes

```bash
kubectl get nodes

---

Output:

NAME       STATUS   ROLES           AGE     VERSION
minikube   Ready    control-plane   2m12s   v1.35.1

---

Step 2: Apply Taint on Node

kubectl taint nodes minikube node=worker:NoSchedule
---
Output:

node/minikube tainted
---

🔍 Step 3: Verify Node Taint
kubectl describe node minikube

Output (important section):

Taints:

node=worker:NoSchedule
---

📊 Step 4: Verify via JSONPath

kubectl get nodes -o jsonpath='{.items[*].spec.taints}'

Output:

[{"effect":"NoSchedule","key":"node","value":"worker"}]
----

🧠 Key Concept
Taints → Prevent pods from being scheduled on a node
Effect: NoSchedule → Blocks new pods unless they have tolerations
Tolerations → Allow pods to bypass taints

🔐 Result
Node: minikube
Taint applied: node=worker:NoSchedule
Normal pods are blocked from scheduling ✔
