# E-Commerce Microservices Application — Docker & Terraform Deployment on AWS

---

This project demonstrates containerizing and deploying a full-stack MERN e-commerce application on AWS using Docker and Terraform. The application follows a microservices architecture with 4 independent Node.js backend services and a React frontend, each running as a separate Docker container on an EC2 instance provisioned entirely through Terraform.

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

### Cloud Platform
- AWS

### Operating System  
- OS: Ubuntu 22.04 LTS

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
   unzip awscliv2.zip
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
   ```

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

   echo \
     "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
     https://download.docker.com/linux/ubuntu \
     $(lsb_release -cs) stable" | \
     sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
   
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

6. Once created, Connect to <your-cluster-name> window will be popped up. Click on **Compass** under Access your data through tools

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

   > [!NOTE]
   > Enter 0.0.0.0/0 to allow access from all IPs (suitable for this lab/demo setup). In production, restrict this to specific IP addresses only.

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

### Task-4: Create env file for Frontend

1. Create .env file using the below command

   ```sh
   nano ./E-Commerce/frontend/.env
   ```

   ```sh
   REACT_APP_USER_SERVICE_URL=PLACEHOLDER_USER_URL
   REACT_APP_PRODUCT_SERVICE_URL=PLACEHOLDER_PRODUCT_URL
   REACT_APP_CART_SERVICE_URL=PLACEHOLDER_CART_URL
   REACT_APP_ORDER_SERVICE_URL=PLACEHOLDER_ORDER_URL
   ```

> [!NOTE]
> Placeholder values are used instead of real IPs so the same Docker image works on any server. The `entrypoint.sh` script replaces these placeholders with the actual server IP at container startup via the `-e` flags passed during `docker run`

### Task-5: Create entrypoint.sh

1. For the frontend application, using a shell script Set placeholder values instead of real IPs, this script replaces the placeholders with the actual env var values passed via `-e` at the container start. Refer to the `entrypoint.sh` file in `E-Commercer\frontend\` folder.

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

### Task-2: Build Docker images for Frontend

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

2. Once testing is complete, stop and clean up local containers

   ```sh
   docker stop user-service product-service cart-service order-service frontend
   docker rm user-service product-service cart-service order-service frontend
   docker network rm ecommerce-net
   ```

### Task-6: Push Docker Images to DockerHub

1. Login to DockerHub using the below command

   ```sh
   docker login
   ```

2. Push all 5 images

   ```sh
   docker push <dockerhub_username>/ecommerce-user-service:latest
   docker push <dockerhub_username>/ecommerce-product-service:latest
   docker push <dockerhub_username>/ecommerce-cart-service:latest
   docker push <dockerhub_username>/ecommerce-order-service:latest
   docker push <dockerhub_username>/ecommerce-frontend:latest
   ```

3. Verify at `https://hub.docker.com/repositories` that all 5 images appear

   <img width="1710" height="520" alt="image" src="https://github.com/user-attachments/assets/e00e4c9d-5720-4a54-b9fd-b161bec41795" />

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
   > `providers.tf` contains the AWS provider configuration including the region. This tells Terraform which cloud provider to use.

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

2. Configure AWS credentials using the below command

   ```sh
   # Configure AWS credentials before initializing
   aws configure
   # Enter: AWS Access Key ID, Secret Access Key, Region, Output format
   ```
   
3. Once all the files were created, initialize terraform in `terraform` directory

   ```sh
   terraform init
   ```

   <img width="568" height="269" alt="image" src="https://github.com/user-attachments/assets/ba2d84d6-c158-4d23-9fee-fdecce0cfdbc" />

4. Plan the terraform configuration

   ```sh
   terraform plan --var-file=terraform.tfvars
   ```
   
   <img width="981" height="387" alt="image" src="https://github.com/user-attachments/assets/ecd1a512-adf6-42ca-b424-28d0862f55bd" />
   <img width="1051" height="790" alt="image" src="https://github.com/user-attachments/assets/6db9dd7a-4f56-4a19-b70c-23e12d82cd13" />

5. Apply the terraform configuration

   ```sh
   terraform apply --var-file=terraform.tfvars --auto-approve
   ```

   > [!NOTE]
   > After terraform apply completes, wait 4-5 minutes before accessing the frontend URL. The EC2 instance needs time to install Docker, pull the images, and start all containers automatically via the user-data script.

   <img width="977" height="625" alt="image" src="https://github.com/user-attachments/assets/089254bf-7d39-412e-b902-1e78ab055aae" />
   <img width="977" height="630" alt="image" src="https://github.com/user-attachments/assets/bb73e94d-9447-49dc-9cb9-c42fec0288bc" />

   > [!NOTE]
   > The `--auto-approve` flag skips the interactive approval step. Remove this flag if you want to review the plan before applying.

5. Copy the `frontend_url` to validate

---

## Phase 5: Verification & Testing

### Task-1: Verification

1. Check the health of all the services

   ```sh
   # Verify all services are running
   curl http://<frontend_ip>/
   curl http://<frontend_ip>:3001/health
   curl http://<frontend_ip>:3002/health
   curl http://<frontend_ip>:3003/health
   curl http://<frontend_ip>:3004/health
   ```
   
2. Open the browser and paste the frontend_url and check all the pages

   <img width="1710" height="1072" alt="image" src="https://github.com/user-attachments/assets/27a0c2a2-60d6-4e3e-a571-7fae703e17ac" />
   <img width="1710" height="1072" alt="image" src="https://github.com/user-attachments/assets/2e32de07-0c23-4c40-ba50-36d8e35930ab" />
   <img width="1710" height="1072" alt="image" src="https://github.com/user-attachments/assets/222f9f0b-9c7c-4c62-926d-652e9a5222e8" />
   <img width="1710" height="1072" alt="image" src="https://github.com/user-attachments/assets/001ac79d-a7a7-42b5-b2d0-be56632a0e4d" />

   > [!NOTE]
   > The Products page shows "No products found" because the database is empty. This confirms the frontend is successfully connected to the product service. Products would appear once added via the API or admin interface.

3. Once verification is done, destroy the terraform resources using the below command

   ```sh
   terraform destroy --var-file=terraform.tfvars --auto-approve
   ```
   
   <img width="975" height="514" alt="image" src="https://github.com/user-attachments/assets/37fef743-5b11-4922-86e7-003b2f902b75" />
   <img width="975" height="514" alt="image" src="https://github.com/user-attachments/assets/507c1884-649e-44cb-8ec2-bc8fe71185a5" />
