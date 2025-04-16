#!/bin/bash
# Find the deployment file
DEPLOYMENT_FILE=$(find . -type f -name "*.yaml" -exec grep -l "kind: Deployment" {} \;)
echo "📦 Deployment file found: ${DEPLOYMENT_FILE}"

# Extract deployment info from the file - get only the Deployment document
NAMESPACE=$(yq eval 'select(.kind == "Deployment") | .metadata.namespace' ${DEPLOYMENT_FILE})
DEPLOY_NAME=$(yq eval 'select(.kind == "Deployment") | .metadata.name' ${DEPLOYMENT_FILE})
CURRENT_IMAGE=$(yq eval 'select(.kind == "Deployment") | .spec.template.spec.containers[0].image' ${DEPLOYMENT_FILE})

echo "🔍 Namespace: ${NAMESPACE}"
echo "📝 Deployment: ${DEPLOY_NAME}"
echo "🐳 Current image in ${DEPLOYMENT_FILE}: ${CURRENT_IMAGE}"

# Cluster version
CURRENT_VERSION=$(kubectl get deployment $DEPLOY_NAME -n $NAMESPACE -o jsonpath='{.spec.template.spec.containers[0].image}' 2>/dev/null || echo "")
echo "🔍 Current version in cluster: ${CURRENT_VERSION}"

echo "🔍 Finding image updater file..."
IMAGE_UPDATER_FILE=$(find . -type f -name "*.yaml" -exec grep -l "kustomize:" {} \;)

if [ -z "$IMAGE_UPDATER_FILE" ]; then
    echo "❌ Image updater file not found!"
    echo "🔍 Updating image on $DEPLOYMENT_FILE..."
    sed -i '' "s|image: ${CURRENT_VERSION}|image: ${CURRENT_IMAGE}|" ${DEPLOYMENT_FILE}
else 
    IMAGE_UPDATER_VERSION=$(cat $IMAGE_UPDATER_FILE  | grep -i "images:" -A1 | tail -n1 | awk '{ print $2 }')
    echo "🔍 Updating image on $DEPLOYMENT_FILE to $IMAGE_UPDATER_VERSION..."
    sed -i '' "s|image: ${CURRENT_IMAGE}|image: ${IMAGE_UPDATER_VERSION}|" ${DEPLOYMENT_FILE}
fi

