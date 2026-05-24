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

### Task-1: Installing Docker Desktop

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
