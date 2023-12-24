#!/bin/bash

RED='\033[0;34m'
NC='\033[0m' # No Color

echo "will use Read,List DevOps profile to get secrets from Akeyless vault:"
echo "========================================================================="
cat ~/.akeyless/profiles/devops.toml |grep id -A1

echo -e "\nsecret value /dev/projects/test-aky/MySod1:"
akeyless get-secret-value --profile devops --name /dev/projects/test-aky/MySod1

echo -e "\nsecret value /dev/projects/test-aky/MySod2"
akeyless get-secret-value --profile devops --name /dev/projects/test-aky/MySod2

echo -e "\n"

