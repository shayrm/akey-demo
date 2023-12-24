#!/bin/bash

echo "Trying to update secret with Read only profile..."
echo "======================================================"
akeyless update-secret-val --profile devops -n /dev/projects/test-aky/MySod1 -v ThisIsAverySecretMessgae-444
