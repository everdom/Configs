#!/bin/bash
echo "install docker-ce using Tsinghua mirror repository..."
sudo apt-get remove docker docker-engine docker.io
sudo apt-get install apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
echo "deb [arch=amd64] https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/debian/ stretch edge">docker.list
sudo mv ./docker.list /etc/apt/sources.list.d/docker.list
sudo apt-get update
sudo apt-get install docker-ce

