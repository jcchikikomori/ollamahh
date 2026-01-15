#!/bin/bash
# Wait for Docker to be available on the host
until docker info >/dev/null 2>&1; do
  echo "Waiting for Docker to be available..."
  sleep 1
done

# Initialize git submodules
echo "Initializing git submodules..."
if ! git submodule update --init --recursive --force --depth=1; then
  echo "Failed to initialize git submodules"
  exit 1
fi

# Start the services using docker-compose
if ! docker compose up; then
  echo "Failed to start containers using docker-compose"
  exit 1
fi

# Wait for the ollama container to be running
until docker ps | grep -q ollama; do
  echo "Waiting for the ollama container to start..."
  sleep 2
done

# Pull the model for Ollama
# if ! docker exec ollama ollama pull llama3:latest; then
#   echo "Failed to pull the Ollama model"
#   exit 1
# fi

# Keep the container running
tail -f /dev/null
