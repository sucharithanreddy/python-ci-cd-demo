#!/usr/bin/env bash
set -e

IMAGE_URI="$1"

if [ -z "$IMAGE_URI" ]; then
  echo "Usage: ./deploy.sh <image-uri>"
  exit 1
fi

CONTAINER_NAME="python-ci-cd-demo"
APP_PORT=8000
HOST_PORT=80

echo "Logging in to ECR..."
aws ecr get-login-password --region "${AWS_REGION:-us-east-1}" | \
  docker login --username AWS --password-stdin "$(echo "$IMAGE_URI" | cut -d'/' -f1)"

echo "Pulling image: $IMAGE_URI"
docker pull "$IMAGE_URI"

echo "Stopping existing container (if running)..."
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
  docker stop "$CONTAINER_NAME"
fi

echo "Removing existing container (if exists)..."
if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
  docker rm "$CONTAINER_NAME"
fi

echo "Starting new container..."
docker run -d \
  --name "$CONTAINER_NAME" \
  -p ${HOST_PORT}:${APP_PORT} \
  "$IMAGE_URI"

echo "Deployment complete. Container running on port ${HOST_PORT}."