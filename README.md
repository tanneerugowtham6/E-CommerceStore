# E-Commerce Microservices Application

---

This project is A full-stack MERN e-commerce application built with microservices architecture, featuring 4 separate Node.js backend services and a React frontend.

---

## Project Execution Overview

This project is executed in **5 phases**, each containing a set of clear deployment tasks required to fully host the E-Commerce Microservices Application on AWS.

### Phases of Deployment

- **Phase 1:** Prerequisites Setup
- **Phase 2:** Creating Dockerfiles
- **Phase 3:** Build and Push Docker Images
- **Phase 4:** Creating Terraform files
- **Phase 5:** Verification & Testing

---

## Environment

### Services
- Docker

### Database
- MongoDB Atlas

## Technology Stack

### Frontend
- React
- JavaScript
- npm

### Backend
- Node.js

### Version Control
- Git

---

## Phase 1: Local Environment Setup 


curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt update && sudo apt install unzip -y
sudo ./aws/install
aws --version


sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt-get update && sudo apt-get install terraform -y


sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://docker.com -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://docker.com \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

sudo usermod -aG docker $USER
docker --version

### Task-1: Installing Docker

1. Install Docker Desktop from https://docs.docker.com/desktop/
2. Verify the installation from Terminal/Command Prompt/CLI
   ```sh
   docker --version
   ```

---

## Phase 2: Dockerfiles and nginx configuration

### Task-1: Create the Dockerfiles for backend

1. Create the `Dockerfile` in all the below folders

   ```
   E-CommerceStore\backend\user-service
   E-CommerceStore\backend\cart-service
   E-CommerceStore\backend\product-service
   E-CommerceStore\backend\order-service
   ```

### Task-2: Create the Dockerfile for frontend

1. Create the `Dockerfile` for frontend

   ```
   E-CommerceStore\frontend\
   ```

### Task-3: Create nginx.conf

1. Create `nginx.conf` in the frontend folder

   ```
   E-CommerceStore\frontend\
   ```
