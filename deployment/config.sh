# Default environment
ENVIRONMENT="dev"

# Parse CLI options
while getopts ":e:" opt; do
  case ${opt} in
    e)
      ENVIRONMENT=$OPTARG
      ;;
  esac
done

# Load respective environment configuration
echo "> Loading ./deployment/environments/${ENVIRONMENT}.env.sh"
source ./deployment/environments/${ENVIRONMENT}.env.sh

# Git variables
export GIT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
export GIT_COMMIT="$(git rev-parse --short HEAD)"
export GIT_COMMIT_MESSAGE="$(git log -1 --pretty=%B HEAD)"

# Docker variables
export DOCKER_REGISTRY="${REGION}-docker.pkg.dev/${PROJECT_ID}/${DOCKER_REPOSITORY}"
export BUILD_VERSION="${GIT_COMMIT}"
