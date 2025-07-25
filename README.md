# Flask-app

Deploying Flask App using Amazon ECS (Fargate) – DebOps
This document explains the step-by-step process to deploy a containerized application (e.g., Flask) using Amazon ECS with Fargate launch type in a serverless setup.

Prerequisites
AWS account with appropriate permissions

1. Docker image pushed to ECR

2. Existing Application Load Balancer (ALB)

3. IAM roles created for ECS tasks and execution

4. Deployment Steps:

Step 1: Create ECS Cluster

Go to the ECS section in AWS.
Create a new Cluster with default Fargate settings.

Step 2: Prepare to Create Service

Inside the newly created Cluster, we need to create a Service.
A Task Definition is required before creating a service.

Step 3: Create Task Definition

Create a new Fargate task definition.

Define container details:
Image URL (from ECR)
Memory & CPU
Port mapping (e.g., 80:80)
Attach IAM Roles:
Execution Role (to pull images, write logs)
Task Role (to access AWS resources like S3, etc.)
Service Role (for ECS service permissions)

Step 4: Register Task Definition

Once created, register the task definition.
Make sure the version is correct and active.

Step 5: Create Service

Go back to the Cluster > Services tab.
Click Create > Choose:
Launch Type: Fargate
Task Definition Family (select the one created above)
Number of Tasks (e.g., 1)
Load Balancing: Application Load Balancer

Step 6: Configure Networking

Select the appropriate VPC and Subnets.
Enable Auto-assign Public IP if needed.

Step 7: Service Created

Once the service is launched, ECS will automatically:
Start tasks based on the definition
Spin up the containers

Step 8: Verify Task and Container

In the Tasks tab, check if the task is running.
Inside each task, verify that the container is running.

Step 9: Configure Target Group

Go to EC2 > Load Balancers > Target Groups.
If a target group doesn’t exist, create one:
Target Type: IP
Protocol: HTTP
Port: 80
Add IP addresses from the ECS tasks

Step 10: ALB Rule Setup

Go to Application Load Balancer > Listeners > View/Edit Rules.

Add a Rule:
Path pattern (e.g., /flaskapp)
Forward to Target Group created above

Step 11: Update ECS Service

Go back to ECS Service.
Click Update if any networking or task changes were made.

Final Verification: 

Access the application using your ALB DNS Name + Path.

Example: http://my-alb-1234.us-east-1.elb.amazonaws.com/flaskapp
