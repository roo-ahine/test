#!/bin/bash

base_image=$1
num_of_images=$2
ecr_repo=$3
account_id=$4
region=$5

# Fetch the latest tags from Docker Hub and store them in an array
tags=($(curl -s https://registry.hub.docker.com/v2/repositories/library/$base_image/tags | jq -r '.results[].name' | head -n$num_of_images))

# Iterate over the array and perform actions on each tag
for tag in "${tags[@]}"; do
    echo "Base image tags: ${tags[@]}"
    echo "Pulling $base_image image tag ${tag}..."
    echo docker pull ${base_image}:${tag}
    echo "Tagging image for ECR..."
    echo docker tag ${base_image}:$tag ${account_id}.dkr.ecr.${region}.amazonaws.com/${ecr_repo}:$tag 
    echo "Pushing ${base_image}:${tag} to ECR..."
    echo docker push ${account_id}.dkr.ecr.${region}.amazonaws.com/${ecr_repo}:$tag
done
