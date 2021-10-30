#!/bin/bash
help()
{
   # Display Help
   echo "Installs Docker and its pre-requisites."
   echo
   echo "Syntax: installdocker.sh [-h]"
   echo "options:"
   echo "h     Print this Help."
   echo
}

while getopts ":h" option; do
   case $option in
      h) # display Help
         help
         exit;;
   esac
done

## Update packages and dependencies
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl gnupg software-properties-common 

## Add GPG key for Docker repo
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

## Add Docker APT repo
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

## Update the package database with Docker packages
sudo apt update

## Install Docker
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose

## Allow Docker commands to be run as a non-root user
sudo usermod -aG docker ${USER}
## Give the current user the ability to run docker
sudo chmod 666 /var/run/docker.sock

exit 0