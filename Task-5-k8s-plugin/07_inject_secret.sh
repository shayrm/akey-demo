

# get helm repo

helm repo add akeyless https://akeylesslabs.github.io/helm-charts
helm repo update

# create values.yaml file
helm show values akeyless/akeyless-secrets-injection > values.yaml

# edit values.yaml file

AKEYLESS_URL: "https://vault.akeyless.io"
#AKEYLESS_ACCESS_ID: "<your-k8s-auth-method-access-id>"
AKEYLESS_ACCESS_ID: "p-8mo8oxm1btaykm"
AKEYLESS_ACCESS_TYPE: "k8s"
#AKEYLESS_K8S_AUTH_CONF_NAME: "<your-k8s-conf-name-in-the-gateway>"
AKEYLESS_K8S_AUTH_CONF_NAME: "k8s-conf"
AKEYLESS_API_GW_URL: " https://54.219.122.226.nip.io:8088"


# create namespace 
kubectl create namespace akeyless
kubectl label namespace akeyless name=akeyless


# install helm

helm install aks akeyless/akeyless-secrets-injection --namespace akeyless -f values.yaml

# ubuntu@ip-172-31-8-121:~/k8s_setup$ helm install aks akeyless/akeyless-secrets-injection --namespace akeyless -f values.yaml
# NAME: aks
# LAST DEPLOYED: Sat Dec 23 16:23:04 2023
# NAMESPACE: akeyless
# STATUS: deployed
# REVISION: 1
# TEST SUITE: None
# ubuntu@ip-172-31-8-121:~/k8s_setup$ kubectl get all -n akeyless
# NAME                                                 READY   STATUS    RESTARTS   AGE
# pod/aks-akeyless-secrets-injection-9fb9d67b7-8dwzb   1/1     Running   0          67s
# pod/aks-akeyless-secrets-injection-9fb9d67b7-tspj9   1/1     Running   0          67s
# 
# NAME                                     TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)   AGE
# service/aks-akeyless-secrets-injection   ClusterIP   10.100.204.172   <none>        443/TCP   67s
# 
# NAME                                             READY   UP-TO-DATE   AVAILABLE   AGE
# deployment.apps/aks-akeyless-secrets-injection   2/2     2            2           67s
# 
# NAME                                                       DESIRED   CURRENT   READY   AGE
# replicaset.apps/aks-akeyless-secrets-injection-9fb9d67b7   2         2         2       67s
# ubuntu@ip-172-31-8-121:~/k8s_setup$
# ubuntu@ip-172-31-8-121:~/k8s_setup$

# Create the init Container and Inject a Secret at Runtime

cat << EOF > env.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: test
spec:
  replicas: 1
  selector:
    matchLabels:
      app: hello-secrets
  template:
    metadata:
      labels:
        app: hello-secrets
      annotations:
        akeyless/enabled: "true"
    spec:
      containers:
      - name: alpine
        image: alpine
        command:
          - "sh"
          - "-c"
	  - "echo $MY_SECRET && echo going to sleep... && sleep 10000"
        env:
        - name: MY_SECRET
          value: akeyless:/dev/projects/test-aky/MySod1
EOF


# for sidecar container:

cat << EOF > sidecar.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: test-file
spec:
  replicas: 1
  selector:
    matchLabels:
      app: file-secrets
  template:
    metadata:
      labels:
        app: file-secrets
      annotations:
        akeyless/enabled: "true"
        akeyless/inject_file: "/dev/projects/test-aky/MySod1|location=/secrets/secretsVersion.json"
        akeyless/side_car_enabled: "true"
        akeyless/side_car_refresh_interval: "30s"
        akeyless/side_car_versions_to_retrieve: "2"
    spec:
      containers:
      - name: alpine
        image: alpine
        command:
          - "sh"
          - "-c"
          - "cat /secrets/secretsVersion.json && echo going to sleep... && sleep 10000"
EOF


