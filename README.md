# Python CI/CD Demo – GitHub Actions → AWS ECR → EC2 Deployment

This project demonstrates a complete **end-to-end CI/CD pipeline** for a containerized Python Flask application.  
Every push to the `main` branch automatically:

1. Runs tests  
2. Builds a Docker image  
3. Pushes the image to **Amazon ECR**  
4. SSHes into an **EC2 instance**  
5. Pulls the latest image  
6. Restarts the container using a custom `deploy.sh` script  

This simulates a real-world DevOps workflow used in production systems.

---

## 📦 Tech Stack

- **Python 3**
- **Flask**
- **Docker**
- **GitHub Actions (CI/CD)**
- **Amazon ECR (Container Registry)**
- **Amazon EC2 (Deployment Server)**
- **Bash Scripting (deploy.sh)**

---

## 🚀 CI/CD Pipeline Overview

The GitHub Actions workflow:

- Installs dependencies  
- Runs automated tests with `pytest`  
- Builds a Docker image  
- Tags it with the commit SHA  
- Pushes it to your ECR repository  
- SSHes into your EC2 instance  
- Executes `deploy.sh`, which:
  - Logs into ECR  
  - Pulls the latest image  
  - Stops any running container  
  - Starts the new container on **port 80**  

---

## 📁 Project Structure

python-ci-cd-demo/
├── app.py
├── requirements.txt
├── tests/
│ └── test_app.py
├── deploy/
│ └── deploy.sh
└── .github/
   └── workflows/
      └── cicd.yml


## 🌐 API Endpoints

Once deployed, access your app at:

http://<EC2_PUBLIC_IP>/api/health → returns {"status": "ok"}
http://<EC2_PUBLIC_IP>/api/hello → returns greeting message

yaml
Copy code

---

## 🔐 GitHub Secrets Required

| Secret Name          | Description |
|----------------------|-------------|
| `AWS_ACCESS_KEY_ID`  | IAM access key |
| `AWS_SECRET_ACCESS_KEY` | IAM secret key |
| `AWS_REGION`         | e.g., `us-east-1` |
| `AWS_ACCOUNT_ID`     | AWS Account ID |
| `ECR_REPOSITORY`     | Name of ECR repo |
| `EC2_HOST`           | EC2 Public IP or DNS |
| `EC2_USER`           | e.g., `ubuntu` |
| `SSH_PRIVATE_KEY`    | Private SSH key for EC2 |

---

## 🧑‍💻 Deployment Script (deploy.sh)

The script on EC2:

- Logs into ECR  
- Pulls latest image  
- Stops existing container  
- Removes old container  
- Starts the new one  

This is executed automatically by GitHub Actions.

---

## ✔ How to Trigger Deployment

Simply push code to the `main` branch:

```bash
git add .
git commit -m "Update"
git push origin main
GitHub Actions will take care of the rest.

🎯 Purpose of This Project
This repository is meant to showcase core DevOps skills, including:

CI/CD automation

AWS infrastructure integration

Docker image lifecycle

Automated deployments via SSH

Real-world deployment scripting

Perfect for learning and portfolio demonstration.
