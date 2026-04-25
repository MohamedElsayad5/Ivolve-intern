# 🚀 Lab 9: Containerized Node.js & MySQL باستخدام Docker Compose

## 📌 Overview
في اللاب ده عملنا containerization لتطبيق Node.js وربطناه مع MySQL باستخدام Docker Compose.

---

## 🧱 Architecture
- Node.js Application (App Service)
- MySQL Database (DB Service)
- Docker Compose orchestration
- Persistent Volume للـ database

---

## ⚙️ Services

### 🔹 App Service
- Built from local Dockerfile
- Exposed on port `3000`
- Environment Variables:
  - DB_HOST=db
  - DB_USER=root
  - DB_PASSWORD=root123

### 🔹 DB Service
- Image: mysql:8
- Environment Variables:
  - MYSQL_ROOT_PASSWORD=root123
  - MYSQL_DATABASE=ivolve
- Volume:
  - db_data → /var/lib/mysql

---

## ▶️ How to Run

```bash
docker compose up --build

---
Access Application

http://localhost:3000

Health Checks

curl http://localhost:3000/health
curl http://localhost:3000/ready

---

Logs

docker exec -it <app_container_id> sh
cd /app/logs

---

Docker Image

docker pull moeyelsayad777/node-app

---

👨‍💻 Author

Mohamed Mahmoud Mohamed Fayed Elsayed
