#!/bin/bash

microk8s enable dashboard dns registry istio
microk8s kubectl get all --all-namespaces
alias mkctl="microk8s kubectl"
alias kubectl="microk8s kubectl"
kubectl version
microk8s dashboard-proxy
microk8s stop
microk8s start