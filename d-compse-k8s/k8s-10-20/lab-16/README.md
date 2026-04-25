# Lab 16: Kubernetes Init Container for Pre-Deployment Database Setup

🧾 Step 2: Create Kubernetes Manifests
nano configmap.yaml  
nano Secret.yaml  
nano Deployment.yaml  
nano Service.yaml  

⚙️ Step 3: Apply Kubernetes Resources
kubectl apply -f ./

Output:
deployment.apps/nodejs-app created  
secret/nodejs-secret created  
service/nodejs-service created  
configmap/nodejs-config created  

🔍 Step 4: Verify Resources

Pods:
kubectl get pods -n ivolve  

Output:
test1   0/1   Pending  
test2   0/1   Pending  
nodejs-app-xxxx   0/1   ContainerCreating  
nodejs-app-xxxx   0/1   ContainerCreating  

Deployment:
kubectl get deploy -n ivolve  

Output:
nodejs-app       0/2   2   0  
app-deployment   0/2   0   0  

Service:
kubectl get svc -n ivolve  

Output:
nodejs-service   ClusterIP   10.106.100.222   <none>   80/TCP  

📌 Step 5: Cluster Status
- Pods initially stuck in Pending / ContainerCreating  
- Deployment created successfully but not fully ready  
- Service created successfully with ClusterIP assigned  

⚠️ Step 6: Issues Observed

1. Taint Issue  
node(s) had untolerated taint(s)

2. Resource Quota Issue  
exceeded quota: pod-limit (2/2 used)

3. Init Container in Deployment  
- MySQL init container added  
- Creates ivolve database  
- Creates app_user and grants privileges  

🧠 Key Concepts
Deployment → Manages Node.js replicas (2 replicas)  
ConfigMap → Stores non-sensitive configuration  
Secret → Stores sensitive credentials securely  
Init Container → Prepares database before app starts  
Tolerations → Allow scheduling on tainted nodes  
ClusterIP Service → Internal load balancing inside cluster  
ResourceQuota → Limits number of pods in namespace  

👨‍💻 Author  
Mohamed Mahmoud Mohamed Fayed Elsayed
