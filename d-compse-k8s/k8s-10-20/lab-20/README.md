# 📌 Lab 20: Securing Kubernetes with RBAC and Service Accounts

## 🎯 Objective
This lab demonstrates Kubernetes RBAC by creating a ServiceAccount, Role, and RoleBinding to control access to Pods in the ivolve namespace.

---

## 📁 Step 1: Namespace
kubectl create namespace ivolve

Output:
Error from server (AlreadyExists): namespaces "ivolve" already exists

---

## 👤 Step 2: Create ServiceAccount
kubectl create serviceaccount jenkins-sa -n ivolve
kubectl get sa -n ivolve

Output:
default      33m
jenkins-sa   11s

---

## 🔐 Step 3: Create ServiceAccount Secret
kubectl apply -f sa-secret.yaml
kubectl get secret -n ivolve
kubectl describe secret jenkins-sa-token -n ivolve

Output:
jenkins-sa-token kubernetes.io/service-account-token

Token successfully generated and linked to jenkins-sa.

---

## 📜 Step 4: Create Role (pod-reader)
Grants:
- get pods
- list pods

kubectl apply -f role.yaml

Output:
role.rbac.authorization.k8s.io/pod-reader created

---

## 🔗 Step 5: Create RoleBinding
kubectl apply -f rolebinding.yaml
kubectl get rolebinding -n ivolve

Output:
pod-reader-binding Role/pod-reader

---

## 🧪 Step 6: Validation

Before fix:
kubectl auth can-i list pods --as=system:serviceaccount:ivolve:jenkins-sa
Output: no

After fix:
kubectl auth can-i list pods --as=system:serviceaccount:ivolve:jenkins-sa -n ivolve
Output: yes

---

## 🧠 Key Concepts
ServiceAccount provides identity inside Kubernetes  
Role defines permissions on resources  
RoleBinding connects Role to ServiceAccount  
RBAC controls access in Kubernetes clusters  

---

## 🎯 Final Result
ServiceAccount created successfully  
Role applied successfully  
RoleBinding attached correctly  
Access verified (YES)

---

## 👨‍💻 Author
Mohamed Mahmoud Mohamed Fayed Elsayed
