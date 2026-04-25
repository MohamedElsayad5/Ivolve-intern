# 📘 Lab 12: ConfigMaps and Secrets in Kubernetes

## 🎯 Objective
This lab demonstrates how to:
- Create and manage Kubernetes ConfigMaps
- Store sensitive data securely using Secrets
- Use base64 encoding for Secret values
- Deploy application using ConfigMap & Secret
- Organize Kubernetes manifests in a structured project

---

## 🧱 Environment
- Kubernetes Cluster (Minikube)
- kubectl configured
- Namespace: ivolve

---

## 🚀 Step 1: Namespace

kubectl create namespace ivolve

Output:
Error from server (AlreadyExists): namespaces "ivolve" already exists

---

## 📦 Step 2: Create YAML Files

nano namespace.yaml  
nano configmap.yaml  
nano secret.yaml  
nano quota.yaml  
nano deployment.yaml  
nano service.yaml  

---

## ⚙️ Step 3: Apply Kubernetes Resources

kubectl apply -f namespace.yaml  
kubectl apply -f configmap.yaml  
kubectl apply -f secret.yaml  
kubectl apply -f quota.yaml  
kubectl apply -f deployment.yaml  
kubectl apply -f service.yaml  

Output:
namespace/ivolve configured  
configmap/app-config created  
secret/mysql-secret created  
resourcequota/pod-limit unchanged  
deployment.apps/app-deployment created  
service/app-service created  

---

## 📁 Step 4: Organize Files

mkdir lab-12  

mv namespace.yaml lab-12/  
mv configmap.yaml lab-12/  
mv secret.yaml lab-12/  
mv quota.yaml lab-12/  
mv deployment.yaml lab-12/  
mv service.yaml lab-12/  

---

## 🔁 Step 5: Re-Apply from Directory

cd lab-12  
kubectl apply -f ./  

Output:
configmap/app-config unchanged  
deployment.apps/app-deployment unchanged  
namespace/ivolve unchanged  
resourcequota/pod-limit unchanged  
secret/mysql-secret unchanged  
service/app-service created  

---

## 🔍 Step 6: Verify Resources

kubectl get pods -n ivolve  

Output:
test1   Pending  
test2   Pending  

---

kubectl get deployment -n ivolve  

Output:
app-deployment   0/2 READY  

---

kubectl get svc -n ivolve  

Output:
app-service   ClusterIP   10.98.14.144   80/TCP  

---

## 🧾 Step 7: Service Definition

apiVersion: v1  
kind: Service  
metadata:  
  name: app-service  
  namespace: ivolve  
spec:  
  selector:  
    app: ivolve-app  
  ports:  
    - port: 80  
      targetPort: 80  
  type: ClusterIP  

---

## 🧠 Key Concepts

ConfigMap → Stores non-sensitive configuration data  
Secret → Stores sensitive data using base64 encoding  
Namespace → Logical isolation of resources  
Deployment → Manages application replicas  
Service → Exposes application inside cluster  

---

## ⚠️ Observations

Pods are in Pending state (needs debugging or scheduling fix)  
Deployment created but not fully running  
Service created successfully  

---

## 👨‍💻 Author

Mohamed Mahmoud Elsayed
