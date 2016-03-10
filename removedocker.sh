#!/bin/bash
# This script removes docker images from the environment
# Author US

docker images

# Delete all containers
docker rm -f $(docker ps -a -q)
# Delete all images
docker rmi -f $(docker images -q)

docker images
