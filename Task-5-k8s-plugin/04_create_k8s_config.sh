#!/bin/bash

akeyless create-auth-method-k8s -n my-k8s-auth-method --bound-pod-names mypod1 \
    --bound-pod-names mypod2 --bound-namespaces akey --json



ACCESS_ID="p-8mo8oxm1bt...,,,..."

PRV_KEY="Something here with a lot of numbers="


