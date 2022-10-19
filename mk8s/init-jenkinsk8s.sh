#!/bin/bash
microk8s enable dashboard dns registry istio hostpath-storage


microk8s status
kubectl create namespace jenkins
kubectl get namespaces
sudo snap install helm --classic
helm repo add jenkinsci https://charts.jenkins.io
helm repo update
helm search repo jenkinsci

#Create Storage
kubectl apply -f jenkins-volume.yaml

#Create Service Account
kubectl apply -f jenkins-sa.yaml

#install jenkins using overide file.
chart=jenkinsci/jenkins
helm install jenkins -n jenkins -f jenkins-values.yaml $chart

#1. Get your 'admin' user password by running:
#  kubectl exec --namespace jenkins -it svc/jenkins -c jenkins -- /bin/cat /run/secrets/additional/chart-admin-password && echo
#2. Get the Jenkins URL to visit by running these commands in the same shell:
#  export NODE_PORT=$(kubectl get --namespace jenkins -o jsonpath="{.spec.ports[0].nodePort}" services jenkins)
#  export NODE_IP=$(kubectl get nodes --namespace jenkins -o jsonpath="{.items[0].status.addresses[0].address}")
#  echo http://$NODE_IP:$NODE_PORT/login

#3. Login with the password from step 1 and the username: admin
#4. Configure security realm and authorization strategy
#5. Use Jenkins Configuration as Code by specifying configScripts in your values.yaml file, see documentation: http:///configuration-as-code and examples: https://github.com/jenkinsci/configuration-as-code-plugin/tree/master/demos

#For more information on running Jenkins on Kubernetes, visit:
#https://cloud.google.com/solutions/jenkins-on-container-engine

#For more information about Jenkins Configuration as Code, visit:
#https://jenkins.io/projects/jcasc/


#NOTE: Consider using a custom image with pre-installed plugins
