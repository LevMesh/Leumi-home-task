#!/bin/bash

ssh ubuntu@3.17.174.1 << EOF


    minikube start
    rm -f Leumi 2> /dev/null
    git clone https://github.com/LevMesh/Leumi.git
    kubectl apply -f Leumi/deployment.yaml
    kubectl port-forward svc/node-svc 8070:5000

EOF