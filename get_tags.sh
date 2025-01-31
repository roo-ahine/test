#!/bin/bash

base_image=$1
num_of_images=$2

# Fetch the latest tags from Docker Hub and store them in an array
tags=($(curl -s https://registry.hub.docker.com/v2/repositories/library/$base_image/tags | jq -r '.results[].name' | head -n$num_of_images))

# Iterate over the array and perform actions on each tag
for tag in "${tags[@]}"; do
    echo "Processing tag: $tag"
    # Add your logic here, e.g., pulling the image or any other operation
    # docker pull $base_image:$tag
done
