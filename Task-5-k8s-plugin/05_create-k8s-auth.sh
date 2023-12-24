#!/bin/bash

akeyless gateway-create-k8s-auth-config  --name k8s-conf \
--gateway-url  https://54.219.122.226.nip.io \
--access-id $ACCESS_ID \
--signing-key $PRV_KEY \
--k8s-host https://79A20081870AAEE59072BC1837340896.gr7.us-west-1.eks.amazonaws.com \
--token-reviewer-jwt $SA_JWT_TOKEN \
--k8s-ca-cert $CA_CERT \
--k8s-issuer $K8S_ISSUER
