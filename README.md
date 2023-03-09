AWS ECS Fargate, NGINX, Docker, and Terraform
This project is a sample application that demonstrates how to use AWS ECS Fargate, NGINX, Docker, and Terraform to deploy and manage a containerized application.

Prerequisites
Before you get started, you will need:

An AWS account
Docker installed on your local machine
Terraform installed on your local machine
Getting Started
To get started with this project, follow these steps:

Clone this repository to your local machine.
Use aws configure to login to your AWS account.
Run terraform init (in ./tf folder) to initialize the Terraform modules.
Run terraform plan to review the Terraform plan.
Run terraform apply to deploy the infrastructure to AWS. you must to change the image url in ecs task (the tf create IAM role for pull the image from Private ECR)
Build the Docker image by running docker build -t my-image . in the root directory of the project.
Push the Docker image to AWS ECR by running docker tag my-image:latest <aws_account_id>.dkr.ecr.<region>.amazonaws.com/my-image:latest followed by docker push <aws_account_id>.dkr.ecr.<region>.amazonaws.com/my-image:latest.
Open the AWS ECS console and verify that the application is running.

Architecture
The architecture of this project is as follows:

A VPC with two public subnets and two private subnets and sg's, nat, igw, routing and many more...
An ECS cluster with two instances running in the private subnets
An ALB in front of the ECS cluster in the public subnets

To develop and test the application locally, follow these steps:

Clone this repository to your local machine.
Build the Docker image by running docker build -t my-image . in the root directory of the project.
Run the Docker container by running docker run -p 80:80 my-image.
Test the application by accessing http://localhost in your web browser.
the db application listing on port 8080. you need to fill the ENV Vars with your RDS mySQL settings
Deployment
To deploy the application to AWS ECS Fargate, follow these steps:

Push the Docker image to AWS ECR by running docker tag my-image:latest <aws_account_id>.dkr.ecr.<region>.amazonaws.com/my-image:latest followed by docker push <aws_account_id>.dkr.ecr.<region>.amazonaws.com/my-image:latest.
You can create Pipeline and codebuild to auto push the image if you push any change in the repo. buildspec inclided. 

Conclusion
This project demonstrates how to use AWS ECS Fargate, NGINX, Docker, and Terraform to deploy and manage a containerized application on AWS. With this setup, you can easily scale your application to handle high traffic loads and make changes to your infrastructure in a repeatable and automated way.