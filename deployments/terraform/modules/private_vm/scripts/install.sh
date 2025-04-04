#!/bin/sh

sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl wget gnupg lsb-release software-properties-common

# Install Keyrins for Microsoft and HashiCorp
curl -sLS https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
sudo chmod go+r /etc/apt/trusted.gpg.d/microsoft.gpg
echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli jammy main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
curl -sLS https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/hashicorp-archive-keyring.gpg > /dev/null
sudo chmod go+r /etc/apt/trusted.gpg.d/hashicorp-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update
sudo apt install -y azure-cli terraform
sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker

#sudo usermod -aG docker $USER

exit 0
