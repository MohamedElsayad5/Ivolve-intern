# Docker Lab 8 - Custom Docker Network (Microservices) 🚀

## 📌 Overview
This lab demonstrates Docker networking using microservices architecture:
- Custom Docker network
- Service-to-service communication
- Default vs user-defined networks

---

## 🏗️ Architecture
- Backend service (Flask)
- Frontend1 (connected to custom network)
- Frontend2 (default network)

---

## 🔹 1. Create Custom Network
```bash
docker network create ivolve-network
