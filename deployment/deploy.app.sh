#!/usr/bin/env bash

# enable strict mode
set -eu

# Load config environment variables
source ./deployment/config.sh

# Docker image names
export APP_DOCKER_IMAGE="${DOCKER_REGISTRY}/app:${BUILD_VERSION}"

# Build dist
npx nx run app:build

## build & push 'app' docker image
docker build \
  --platform linux/amd64 \
  --tag ${APP_DOCKER_IMAGE} \
  --file ./deployment/docker/app.Dockerfile .
docker push ${APP_DOCKER_IMAGE}

# Deploy services & jobs to Google Cloud

## Render and deploy app service
#gcloud run services replace $(./deployment/utils/render.sh deployment/services/app.service.yaml) --region=${REGION} --project=${PROJECT_ID}