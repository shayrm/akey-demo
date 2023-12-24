#!/bin/bash

echo "list current namespaces:"
echo ""
if [ -z $1 ]
then
	echo "Error: ns is missing - usage: $0 <ns>"
	echo -e "Choose namespace from the list below: \n"
	kubectl get ns
	exit
fi

echo "change ns to $1"
kubectl config set-context --current --namespace $1

