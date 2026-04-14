# Docker Lab 7 - Volume & Bind Mount with Nginx 🚀

## 📌 Overview
This lab demonstrates Docker storage concepts:
- Docker Volumes (persistent storage)
- Bind Mounts (host-to-container sync)
- Nginx web server

---

## 🔹 1. Create Volume
Created a Docker volume to persist Nginx logs:

```bash
docker volume create nginx_logs
