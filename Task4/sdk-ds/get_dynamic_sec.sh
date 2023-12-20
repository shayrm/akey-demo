#!/bin/bash

access_key="p-lqq035v2rmqaem"

curl --request POST \
     --url https://api.akeyless.io/auth \
     --header 'accept: application/json' \
     --header 'content-type: application/json' \
     --data @<(cat <<EOF
{
  "access-type": "$access_key",
  "gcp-audience": "akeyless.io",
  "json": false
  }
EOF
)
    
    
  
