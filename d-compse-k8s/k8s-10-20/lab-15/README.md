# 📘 Lab 15: Node.js Application Deployment with ClusterIP Service

## 🎯 Objective
This lab demonstrates how to:
- Deploy a Node.js application using Kubernetes Deployment
- Use ConfigMap and Secret for environment variables
- Apply tolerations for scheduling rules
- Expose the application using a ClusterIP Service

---

## ⚙️ Step 3: Apply Kubernetes Resources
kubectl apply -f ConfigMap.yaml  
kubectl apply -f Secret.yaml  
kubectl apply -f deployment.yaml  
kubectl apply -f service.yaml  

Output:
configmap/nodejs-config created  
secret/nodejs-secret created  
deployment.apps/nodejs-app created  
service/nodejs-service created  

---

## 🔍 Step 4: Verify Resources

Pods:
kubectl get pods  

Output:
mysql-0 1/1 Running  
nodejs-app-75cf94d894-2b65c 0/1 ContainerCreating  
nodejs-app-75cf94d894-gb88f 0/1 ContainerCreating  

---

Deployment:
kubectl get deploy  

Output:
nodejs-app 0/2 2 0  

---

Service:
kubectl get svc  

Output:
nodejs-service ClusterIP 10.106.100.222 <none> 80/TCP  

---

## 📌 Step 5: Cluster Status
Pods are in ContainerCreating state initially.  
Deployment is created successfully but not fully ready.  
Service is created and assigned ClusterIP successfully.  

---

## 🧠 Key Concepts
Deployment → Manages Node.js replicas  
ConfigMap → Stores non-sensitive configuration  
Secret → Stores sensitive data securely  
Tolerations → Allow scheduling on tainted nodes  
ClusterIP Service → Internal load balancing  

---

## ⚠️ Observations
Pods initially stuck in ContainerCreating  
Deployment not fully available yet  
Service created successfully inside cluster  

---

## 👨‍💻 Author
Mohamed Mahmoud Elsayed
