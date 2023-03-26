#!/bin/bash

scp -P 22 deployment.yaml ubuntu@18.216.32.68:~

ssh ubuntu@18.216.32.68 << EOF

    minikube start
    docker pull levvv/python-app:1.5.8
    kubectl apply -f Leumi/deployment.yaml
    kubectl port-forward svc/node-svc 8070:5000

EOF