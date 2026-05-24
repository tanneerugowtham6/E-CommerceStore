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

### Task-2: Install Terraform

1. Execute the below commands to install Terraform

   ```
   sudo apt-get install -y gnupg software-properties-common
   
   wget -O- https://apt.releases.hashicorp.com/gpg | \
   gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
   
   echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
   https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
   sudo tee /etc/apt/sources.list.d/hashicorp.list
   
   sudo apt-get update && sudo apt-get install terraform -y

### Task-3: Install Docker

1. Execute the below commands to install  Docker

   ```
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
   ```

### Task-4: Configure the MongoDB

1. Sign in to your MongoDB Atlas account (https://www.mongodb.com/cloud/atlas)
2. Once logged in, click on `Create a cluster`

    <img width="1204" height="578" alt="image" src="https://github.com/user-attachments/assets/88a8357c-78ed-4b35-aa26-328495bbe0c6" />

3. Select the required plan, since it's a demo, going with a `free` plan

    <img width="1419" height="483" alt="image" src="https://github.com/user-attachments/assets/09dc27b3-acd8-4c6b-a459-f9fe9df443b3" />

4. Enter the required details under the **Configurations** section like, **Name, Provider, Region**

    <img width="708" height="504" alt="image" src="https://github.com/user-attachments/assets/86805543-023a-476d-8fad-55609e63fe87" />

5. Click on **Create Deployment**

    <img width="513" height="91" alt="image" src="https://github.com/user-attachments/assets/28f40b1f-32dc-49dd-b2bd-eb19f26a4bd1" />

6. Once created, Connect to <your-cluster-name> window will be popped up. Click on **Compass**

    <img width="829" height="838" alt="image" src="https://github.com/user-attachments/assets/6d52e18a-926b-45b5-b895-5edfa52041f7" />

7. Select **I have MongoDB Compass installed**, copy the connection string [Save this for later steps]

    <img width="829" height="856" alt="image" src="https://github.com/user-attachments/assets/de0720af-df4b-4c55-9a5f-486360f4b99b" />

    **NOTE:** If you do not have MongoDB Compass installed, download it from https://downloads.mongodb.com/compass/mongodb-compass-1.48.2-darwin-arm64.dmg

8. Click on **Done**

9. On the left sidebar, click on **Database & Network Access**

    <img width="469" height="697" alt="image" src="https://github.com/user-attachments/assets/65cb8e4e-4cb7-4c98-a8b5-bbc1e40421e8" />

10. Click on **ADD NEW DATABASE USER**

    <img width="1440" height="113" alt="image" src="https://github.com/user-attachments/assets/925f3321-40fd-40c0-bba3-323013dcba1b" />

11. Enter a username and password

    <img width="978" height="599" alt="image" src="https://github.com/user-attachments/assets/197c01f6-db9c-4226-bb8b-eaf2bf93f9c0" />

12. Goto **Database User Privileges** section, under **Built-in Role**, select **Read and write to any database**. Click on **Add User**

    <img width="953" height="720" alt="image" src="https://github.com/user-attachments/assets/676d6a56-996e-4b62-9eff-a5761c065813" />

13. Click on **IP Access List** on the left sidebar. Click on **ADD IP ADDRESS**

    <img width="1433" height="109" alt="image" src="https://github.com/user-attachments/assets/79fa3f63-ad1f-4760-a9df-514639826637" />
    <img width="613" height="474" alt="image" src="https://github.com/user-attachments/assets/7b815764-4fc2-4120-b5a6-864d89727cb6" />

14. Click on **Save Changes**

### Task-5: Connect to Database using MongoDB Compass

1. Launch MongoDB Compass, click on **Add new connection**

    <img width="1424" height="747" alt="image" src="https://github.com/user-attachments/assets/23dbfac0-9624-4d06-afc9-f56a054ddcc8" />

2. Enter the **Connection string** copied from the previous task in the **New Connection** tab under **URI**

    <img width="1921" height="1000" alt="image" src="https://github.com/user-attachments/assets/00d151c1-5abb-4b00-a283-16dca6503218" />

    Replace <db_password> with your password created in the previous task.
   
4. Click on **Save & Connect**
5. Save your MongoDB Connection URI, as this may be required for further configuration.

---

## Phase 2: Dockerfiles and nginx configuration

### Task-1: Create the Dockerfiles for backend

1. Create the `Dockerfile` in all the below folders for backend services

   ```
   E-CommerceStore\backend\user-service
   E-CommerceStore\backend\cart-service
   E-CommerceStore\backend\product-service
   E-CommerceStore\backend\order-service
   ```

> [!NOTE]
> As mentioned in the Application_Details.md, few variables to be passed using .env for the application. The same will be passed through docker environment variables using `-e` tag.

### Task-2: Create the Dockerfile for frontend

1. Create the `Dockerfile` for frontend

   ```
   E-CommerceStore\frontend\
   ```

> [!NOTE]
> As mentioned in the Application_Details.md, few variables to be passed using .env for the application. The same will be passed through docker environment variables using `-e` tag.

### Task-3: Create nginx.conf

1. Create `nginx.conf` in the frontend folder

   ```
   E-CommerceStore\frontend\
   ```

.env in frontend
<img width="492" height="87" alt="image" src="https://github.com/user-attachments/assets/ee37ebef-7be3-4623-ac1f-632d01a2d34a" />

### Task-4: Create entrypoint.sh

1. For the frontend application, using a shell script Set placeholder values instead of real IPs, this script replaces the placeholders with the actual env var values passed via `-e` at the container start. Refere to the `entrypoint.sh` file in `E-Commercer\frontend\` folder.

---

## Phase 3: Build and Push Docker images

### Task-1: Build Docker images for Backend

1. Navigate the below paths and build the docker images using the below command

   ```
   ./E-CommerceStore/backend/user-service
   ./E-CommerceStore/backend/product-service
   ./E-CommerceStore/backend/cart-service
   ./E-CommerceStore/backend/order-service
   ```

   ```sh
   docker build -t <dockerhub_username>/<image-name>:<tag> <dockerfile_directory>
   ```

   **User Service**
   <img width="1685" height="339" alt="image" src="https://github.com/user-attachments/assets/df97791e-879d-4368-85aa-9d9554eab2e7" />

   **Product Service**
   <img width="1685" height="339" alt="image" src="https://github.com/user-attachments/assets/3cf1c7a6-6c3d-4715-8614-894897ee80c4" />

   **Cart Service**
   <img width="1685" height="339" alt="image" src="https://github.com/user-attachments/assets/46fa18aa-4b12-4560-a2cb-fcac4540368a" />

   **Order Service**
   <img width="1685" height="337" alt="image" src="https://github.com/user-attachments/assets/db1d2763-d07a-443c-8deb-c21261fac695" />

### Task-2: Build Docker images for Backend

1. Navigate the below paths and build the docker images using the below command

   ```
   ./E-CommerceStore/frontend/
   ```

   ```sh
   docker build -t <dockerhub_username>/<image-name>:<tag> <dockerfile_directory>
   ```

   **Frontend**
   <img width="1685" height="616" alt="image" src="https://github.com/user-attachments/assets/d8b5fe64-48e5-49ae-9cbd-5dd66059f852" />

### Task-3: Verify Docker images

1. Verify if the images created successfully

   ```sh
   docker images
   ```
   
   <img width="1685" height="128" alt="image" src="https://github.com/user-attachments/assets/f12ac811-3a90-4958-b9c1-2e08559e1d07" />

### Task-4: Test Images Locally

1. Create the Docker Network using the below command

   ```sh
   docker network create <network-name>
   ```

   <img width="566" height="48" alt="image" src="https://github.com/user-attachments/assets/de88010c-0ad6-42b7-94e8-7f523e19330a" />
2. Run the containers for all backend services and frontend locally using the images created

   ```sh
   docker run -d --name <container-name> --network <container-network> -p <host-port>:<container-port> -e <env-variable>=<value> <docker-image-name>:<tag-optional>
   ```
   
   <img width="1681" height="209" alt="image" src="https://github.com/user-attachments/assets/b3e7b2a7-04fe-4c36-8275-ad65e419c603" />

### Task-5: Check Container Status

1. Check whether the containers are running fine using the below command

   ```sh
   docker ps
   ```
   
   <img width="1470" height="113" alt="image" src="https://github.com/user-attachments/assets/da2f8188-c48a-4573-84f6-59280b3b1d7c" />

---

## Phase 4: Terraform Configuration

### Task-1: Create the Terraform files

1. Create the terraform file as the per the below structure

   ```
   E-Commerce\
   |_ terraform
      |_ providers.tf
      |_ main.tf
      |_ variables.tf
      |_ outputs.tf
      |_ terraform.tfvars
      |_ user-data.sh
   ```

   > [!NOTE]
   > All these files exists in this repository except `terraform.tfvars`, make sure all the below variables to be passed through `terraform.tfvars` file

   ```sh
   instance_type = <value>
   key_pair_name = <value>
   aws_region    = <value>
   ami_id         = <value>
   dockerhub_username = <value>
   mongo_uri          = <connection-string>
   jwt_secret         = <any-secret-key>
   ```

2. Once all the files were created, initialize terraform in `terraform` directory

   ```sh
   terraform init
   ```

   <img width="568" height="269" alt="image" src="https://github.com/user-attachments/assets/ba2d84d6-c158-4d23-9fee-fdecce0cfdbc" />

3. Plan the terraform configuration

   ```sh
   terraform plan --var-file=terraform.tfvars
   ```
   
   <img width="981" height="387" alt="image" src="https://github.com/user-attachments/assets/ecd1a512-adf6-42ca-b424-28d0862f55bd" />
   <img width="1051" height="790" alt="image" src="https://github.com/user-attachments/assets/6db9dd7a-4f56-4a19-b70c-23e12d82cd13" />

4. Apply the terraform configuration

   ```sh
   terraform apply --var-file=terraform.tfvars --auto-approve
   ```
   
   <img width="977" height="625" alt="image" src="https://github.com/user-attachments/assets/089254bf-7d39-412e-b902-1e78ab055aae" />
   <img width="977" height="630" alt="image" src="https://github.com/user-attachments/assets/bb73e94d-9447-49dc-9cb9-c42fec0288bc" />

5. Copy the `frontend_url` to validate

---

## Phase 5: Verification & Testing

### Task-1: Verification

1. Open the browser and paste the frontend_url and check all the pages

   <img width="1710" height="1072" alt="image" src="https://github.com/user-attachments/assets/27a0c2a2-60d6-4e3e-a571-7fae703e17ac" />
   <img width="1710" height="1072" alt="image" src="https://github.com/user-attachments/assets/2e32de07-0c23-4c40-ba50-36d8e35930ab" />
   <img width="1710" height="1072" alt="image" src="https://github.com/user-attachments/assets/222f9f0b-9c7c-4c62-926d-652e9a5222e8" />
   <img width="1710" height="1072" alt="image" src="https://github.com/user-attachments/assets/001ac79d-a7a7-42b5-b2d0-be56632a0e4d" />

2. Once verification is done, destroy the terraform resources using the below command

   ```sh
   terraform destroy --var-file=terraform.tfvars --auto-approv
   ```
   
   <img width="975" height="514" alt="image" src="https://github.com/user-attachments/assets/37fef743-5b11-4922-86e7-003b2f902b75" />
   <img width="975" height="514" alt="image" src="https://github.com/user-attachments/assets/507c1884-649e-44cb-8ec2-bc8fe71185a5" />
