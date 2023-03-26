#!/bin/bash


#################################################################
###################### Download Jenkins #########################
#################################################################

# sudo amazon-linux-extras install java-openjdk11
# sudo yum -y install wget
# sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
# sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
# sudo yum upgrade -y
# sudo yum install jenkins -y
# sudo systemctl start jenkins
# sudo systemctl enable jenkins.service
##wget http://localhost:8080/jnlpJars/jenkins-cli.jar -- later on must work on installing plugins with jenkins-cli.jar file.

#################################################################
######################## Download Git ###########################
#################################################################


# ssh-keygen

# ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

# sudo rpm -ivh https://github.com/aquasecurity/trivy/releases/download/v0.36.1/trivy_0.36.1_Linux-64bit.rpm

# curl https://get.datree.io | /bin/bash

############# HELM


# curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3

# chmod 700 get_helm.sh

# ./get_helm.sh

# helm plugin install https://github.com/datreeio/helm-datree

# helm plugin update datree

#################################################################
####################### Download Docker #########################
#################################################################


# sudo apt install git -y

# sudo curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"




# sudo apt update -y
# sudo yum install docker -y
# sudo service docker start
# sudo systemctl enable docker.service
# sudo usermod -a -G docker ec2-user
# sudo usermod -a -G docker jenkins


#sudo usermod -aG docker $USER && newgrp docker

# sudo curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# sudo curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

# sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# sudo reboot



#sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin





sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

sudo usermod -aG docker ubuntu && newgrp docker


curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo dpkg -i minikube_latest_amd64.deb



curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"


curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"


sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

docker pull gcr.io/k8s-minikube/kicbase

docker pull nginx

minikube start

# git clone https://github.com/LevMesh/Leumi.git

# kubectl apply -f Leumi/deployment.yaml

# kubectl port-forward svc/node-svc 8070:5000