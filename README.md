# Flask-app

# Deploying Flask App to Amazon ECS (Fargate)

This document outlines the steps followed to deploy a Flask application using Amazon ECS with Fargate, along with a CI/CD pipeline using GitHub Actions. This approach helps run the application on a serverless container platform without managing infrastructure manually.

##Tech Stack Used

- **Amazon ECS (Fargate)** – for serverless container orchestration  
- **Amazon ECR** – for storing Docker images  
- **GitHub Actions** – to automate build and deployment  
- **Docker** – to containerize the Flask application  
- **Python Flask** – the web application framework used  

##ECS Deployment Steps

### Step 1: Create ECS Cluster

- Navigated to ECS service in AWS Console  
- Chose the **Networking only (Fargate)** option  
- Named the cluster (e.g., `demo-cluster`)  

### Step 2: Service Preparation

- Ensured a Task Definition was ready before creating a service in the cluster  

### Step 3: Task Definition Creation

- Went to **ECS > Task Definitions > Create new**
- Selected **FARGATE** as the launch type  
- Added container info (e.g., image: Flask app or NGINX)  
- Mapped ports `80 → 80`  
- Allocated **256 CPU**, **512MB RAM**  
- Attached required IAM roles:  
  - Execution Role  
  - Task Role  
  - *(Optional)* Service Role  

### Step 4: Task Registration

- Registered the task definition under a family name (e.g., `flask-dev`)  
- Configured **CloudWatch Logs** using the `awslogs` driver  

### Step 5: Create ECS Service

- Used the task definition created above  
- Launch type: **FARGATE**  
- Task count: **1**  
- Integrated with an **Application Load Balancer (ALB)**  

### Step 6: Networking Configuration

- Selected appropriate **VPC and Subnets**  
- Enabled **Auto-assign Public IP**  

### Step 7: Launch and Verification

- ECS automatically launched the container based on the task definition  
- Verified task and container status in the ECS console  

### Step 8: Target Group Setup

- Went to **EC2 > Target Groups** under Load Balancing  
- Created a new target group:  
  - Type: **IP**  
  - Protocol: **HTTP**  
  - Added the ECS task IP  

### Step 9: ALB Rule Configuration

- Navigated to **ALB Listener Rules**  
- Added a new routing rule:  
  - **Path**: `/flask`  
  - **Action**: Forward to the target group  

### Step 10: ECS Service Update (If Required)

- Updated the ECS service when a new Docker image or task definition is available  

##CI/CD Pipeline with GitHub Actions

Configured **GitHub Actions** using a workflow file under `.github/workflows/deploy.yml`.  
This automates the following steps:

- Code checkout  
- AWS login  
- Docker image build & push to ECR  
- ECS service deployment  

##Summary

- Deployed Flask app on **ECS with Fargate (serverless)**  
- **CI/CD pipeline** set up using GitHub Actions  
- **Dockerized app** stored in Amazon ECR  
- Load balancing configured using **ALB and target groups**  
