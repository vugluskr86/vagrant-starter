#!/usr/bin/env bash

echo "Downloading Jenkins Key"

wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -

echo "Installing Jenkins Key"

sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'

echo "Installing Jenkins"

sudo apt-get update
sudo apt-get install -y jenkins

echo "Installing Jenkins complete"