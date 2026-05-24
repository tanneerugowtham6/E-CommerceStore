#!/bin/bash
exec > var/log/user-data.log 2>&1
echo "Starting user-data script execution at $(date)"

# Update System Packages
apt-get update -y
apt-get upgrade -y

# Install Docker
apt-get install -y ca-certificates curl gnupg lsb-release
mkdir -p /etc/apt/keyrings
apt-get install docker.io -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
systemctl start docker
systemctl enable docker
usermod -aG docker ubuntu
echo "Docker installed and configured successfully with $(docker --version)"

# Create Docker Network
docker network create ecommerce-net

# Pull Docker Images from Docker Hub
DHUSER = "${dockerhub_username}"
docker pull $DHUSER/ecommerce_user-service:latest
docker pull $DHUSER/ecommerce_product-service:latest
docker pull $DHUSER/ecommerce_cart-service:latest
docker pull $DHUSER/ecommerce_order-service:latest
docker pull $DHUSER/ecommerce_frontend:latest
echo "Docker images pulled successfully from Docker Hub"

# Get the Public IP of the EC2 instance
PUBLIC_IP=$(curl -s ifconfig.me)
echo "EC2 instance public IP: $PUBLIC_IP"

# Run Docker Containers
docker run -d \
--name user-service \
--network ecommerce-net \
-p 3001:3001 \
-e PORT=3001 \
-e MONGODB_URI="${mongodb_uri}/ecommerce_users" \
-e JWT_SECRET="${jwt_secret}" \
$DHUSER/ecommerce-user-service:latest

echo "User Service container started successfully"

docker run -d \
--name product-service \
--network ecommerce-net \
-p 3002:3002 \
-e PORT=3002 \
-e MONGODB_URI="${mongodb_uri}/ecommerce_products" \
$DHUSER/ecommerce_product-service:latest

echo "Product Service container started successfully"

docker run -d \
--name cart-service \
--network ecommerce-net \
-p 3003:3003 \
-e PORT=3003 \
-e MONGODB_URI="${mongodb_uri}/ecommerce_carts" \
-e PRODUCT_SERVICE_URL=http://product-service:3002 \
$DHUSER/ecommerce_cart-service:latest

echo "Cart Service container started successfully"

docker run -d \
--name order-service \
--network ecommerce-net \
-p 3004:3004 \
-e PORT=3004 \
-e MONGODB_URI="${mongodb_uri}/ecommerce_orders" \
-e CART_SERVICE_URL=http://cart-service:3003 \
-e PRODUCT_SERVICE_URL=http://product-service:3002 \
-e USER_SERVICE_URL=http://user-service:3001 \
$DHUSER/ecommerce_order-service:latest

echo "Order Service container started successfully"

docker run -d \
--name frontend \
--network ecommerce-net \
--restart unless-stopped \
-p 80:80 \
$DHUSER/ecommerce_frontend:latest

echo "Frontend container started successfully"

#Verify that all containers are running
if docker ps | grep -q "user-service" && \
   docker ps | grep -q "product-service" && \
   docker ps | grep -q "cart-service" && \
   docker ps | grep -q "order-service" && \
   docker ps | grep -q "frontend"; then
    echo "All Docker containers are running successfully"
else
    echo "Error: One or more Docker containers failed to start"
    exit 1
fi
echo "User-data script execution completed at $(date)"