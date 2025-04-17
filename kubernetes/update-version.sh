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
echo "🐳 Current image in ${DEPLOYMENT_FILE} => ${CURRENT_IMAGE}"

# Cluster version
CURRENT_VERSION=$(kubectl get deployment $DEPLOY_NAME -n $NAMESPACE -o jsonpath='{.spec.template.spec.containers[0].image}' 2>/dev/null || echo "")
echo "🔍 Current version in cluster => ${CURRENT_VERSION}"

echo "📝 Checking for image updater file..."
IMAGE_UPDATER_FILE=$(find . -type f -name ".argocd-source-*.yaml")

if [ -z "$IMAGE_UPDATER_FILE" ]; then
    echo "❌ Image updater file not found!"
    if [ "${CURRENT_IMAGE}" != "${CURRENT_VERSION}" ]; then
        echo "🔍 Updating deployment with cluster version..."
        sed -i '' "s|image: ${CURRENT_IMAGE}|image: ${CURRENT_VERSION}|" ${DEPLOYMENT_FILE}
    else
        echo "✅ Deployment file is already in sync with cluster version!"
    fi
else 
    echo "📄 Found image updater file: ${IMAGE_UPDATER_FILE}"
    IMAGE_UPDATER_VERSION=$(cat $IMAGE_UPDATER_FILE | grep -i "images:" -A1 | tail -n1 | awk '{ print $2 }')
    if [ -z "$IMAGE_UPDATER_VERSION" ]; then
        echo "❌ Could not find image version in $IMAGE_UPDATER_FILE"
        if [ "${CURRENT_IMAGE}" != "${CURRENT_VERSION}" ]; then
            echo "🔍 Falling back to cluster version..."
            sed -i '' "s|image: ${CURRENT_IMAGE}|image: ${CURRENT_VERSION}|" ${DEPLOYMENT_FILE}
        fi
    else
        echo "📦 Image updater version found => ${IMAGE_UPDATER_VERSION}"
        if [ "${IMAGE_UPDATER_VERSION}" != "${CURRENT_VERSION}" ]; then
            echo "⚠️ Warning: Image updater version (${IMAGE_UPDATER_VERSION}) differs from cluster version (${CURRENT_VERSION})"
            echo "🔄 Using cluster version instead..."
            echo "🔍 Updating deployment with cluster version..."
            sed -i '' "s|image: ${CURRENT_IMAGE}|image: ${CURRENT_VERSION}|" ${DEPLOYMENT_FILE}
            echo "🔄 Updating image updater file with cluster version..."
            sed -i '' "s|${IMAGE_UPDATER_VERSION}|${CURRENT_VERSION}|" ${IMAGE_UPDATER_FILE}
            echo "✅ Done!"
        else
            if [ "${CURRENT_IMAGE}" != "${IMAGE_UPDATER_VERSION}" ]; then
                echo "🔍 Updating image on $DEPLOYMENT_FILE to ${IMAGE_UPDATER_VERSION}..."
                sed -i '' "s|image: ${CURRENT_IMAGE}|image: ${IMAGE_UPDATER_VERSION}|" ${DEPLOYMENT_FILE}
                echo "✅ Done!"
            else
                echo "✅ Deployment file is already in sync with image updater version!"
            fi
        fi
    fi
fi      
