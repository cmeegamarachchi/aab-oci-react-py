#!/bin/bash

# Define image name and container name
IMAGE_NAME="aab-oci-react-py"
CONTAINER_NAME="aab-oci-react-py"

# Read ports from environment variables or set default values
FRONTEND_PORT=${FRONTEND_PORT:-3000}
API_PORT=${API_PORT:-8000}

echo "Building the frontend..."
cd frontend || exit 1
npm install && npm run build
cd - || exit 1

echo "Building the backend..."
cd api || exit 1
pip install --no-cache-dir -r requirements.txt
cd - || exit 1

echo "Building the Docker image..."
docker build --build-arg FRONTEND_PORT=$FRONTEND_PORT --build-arg API_PORT=$API_PORT -t $IMAGE_NAME .

echo "Stopping and removing any existing container..."
docker stop $CONTAINER_NAME 2>/dev/null || true
docker rm $CONTAINER_NAME 2>/dev/null || true

echo "Running the new container..."
docker run -d --name $CONTAINER_NAME -p $FRONTEND_PORT:$FRONTEND_PORT -p $API_PORT:$API_PORT $IMAGE_NAME

echo "Deployment complete!"
echo "Frontend available at: http://localhost:$FRONTEND_PORT"
echo "API available at: http://localhost:$API_PORT"
