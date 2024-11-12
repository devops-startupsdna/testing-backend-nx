#!/usr/bin/env bash

# enable strict mode
set -eu

# Load config environment variables
source ./deployment/config.sh

# Docker image names
export APP_DOCKER_IMAGE="${DOCKER_REGISTRY}/app:${BUILD_VERSION}"
export APP_SERVICE_SPEC="deployment/services/app.service.yaml"

## Render and deploy app service
yq -i ".spec.template.spec.containers[0].image = \"$APP_DOCKER_IMAGE\"" $APP_SERVICE_SPEC
gcloud run services replace $APP_SERVICE_SPEC --region=${REGION} --project=${PROJECT_ID}
