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

## Phase 1: Prerequisites Setup 

### Task-1: Install AWS CLI

1. Login to the machine which will be used (For this task a Ubuntu server has been used)

   ```
   curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
   sudo apt update && sudo apt install unzip -y
   sudo ./aws/install
   aws --version
   ```


sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt-get update && sudo apt-get install terraform -y


sudo apt update
sudo apt upgrade -y
sudo apt install -y \
  ca-certificates \
  curl \
  gnupg \
  lsb-release
sudo mkdir -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo apt update
sudo apt install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker
sudo usermod -aG docker $USER
newgrp docker
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

.env in frontend
<img width="492" height="87" alt="image" src="https://github.com/user-attachments/assets/ee37ebef-7be3-4623-ac1f-632d01a2d34a" />


---

## Phase 3: Build and Push Docker images

### Task-1: Build Docker images for Backend

user-service
<img width="1685" height="339" alt="image" src="https://github.com/user-attachments/assets/df97791e-879d-4368-85aa-9d9554eab2e7" />

product-service
<img width="1685" height="339" alt="image" src="https://github.com/user-attachments/assets/3cf1c7a6-6c3d-4715-8614-894897ee80c4" />

cart-service
<img width="1685" height="339" alt="image" src="https://github.com/user-attachments/assets/46fa18aa-4b12-4560-a2cb-fcac4540368a" />

order-service
<img width="1685" height="337" alt="image" src="https://github.com/user-attachments/assets/db1d2763-d07a-443c-8deb-c21261fac695" />

frontend
<img width="1685" height="616" alt="image" src="https://github.com/user-attachments/assets/d8b5fe64-48e5-49ae-9cbd-5dd66059f852" />

Confirm images exists
<img width="1685" height="128" alt="image" src="https://github.com/user-attachments/assets/f12ac811-3a90-4958-b9c1-2e08559e1d07" />

Test Locally

Docker network
<img width="566" height="48" alt="image" src="https://github.com/user-attachments/assets/de88010c-0ad6-42b7-94e8-7f523e19330a" />

Run containers locally
<img width="1681" height="209" alt="image" src="https://github.com/user-attachments/assets/b3e7b2a7-04fe-4c36-8275-ad65e419c603" />

Check containers status
<img width="1470" height="113" alt="image" src="https://github.com/user-attachments/assets/da2f8188-c48a-4573-84f6-59280b3b1d7c" />

terraform init
<img width="568" height="269" alt="image" src="https://github.com/user-attachments/assets/ba2d84d6-c158-4d23-9fee-fdecce0cfdbc" />

terraform plan
<img width="981" height="387" alt="image" src="https://github.com/user-attachments/assets/ecd1a512-adf6-42ca-b424-28d0862f55bd" />
<img width="1051" height="790" alt="image" src="https://github.com/user-attachments/assets/6db9dd7a-4f56-4a19-b70c-23e12d82cd13" />

terraform apply
<img width="977" height="625" alt="image" src="https://github.com/user-attachments/assets/089254bf-7d39-412e-b902-1e78ab055aae" />
<img width="977" height="630" alt="image" src="https://github.com/user-attachments/assets/bb73e94d-9447-49dc-9cb9-c42fec0288bc" />

terraform destroy
<img width="975" height="514" alt="image" src="https://github.com/user-attachments/assets/37fef743-5b11-4922-86e7-003b2f902b75" />
<img width="975" height="514" alt="image" src="https://github.com/user-attachments/assets/507c1884-649e-44cb-8ec2-bc8fe71185a5" />

verification
<img width="1710" height="1072" alt="image" src="https://github.com/user-attachments/assets/27a0c2a2-60d6-4e3e-a571-7fae703e17ac" />
<img width="1710" height="1072" alt="image" src="https://github.com/user-attachments/assets/2e32de07-0c23-4c40-ba50-36d8e35930ab" />
<img width="1710" height="1072" alt="image" src="https://github.com/user-attachments/assets/222f9f0b-9c7c-4c62-926d-652e9a5222e8" />
<img width="1710" height="1072" alt="image" src="https://github.com/user-attachments/assets/001ac79d-a7a7-42b5-b2d0-be56632a0e4d" />
