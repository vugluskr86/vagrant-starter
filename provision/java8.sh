#!/usr/bin/env bash

if which java >/dev/null; then
    echo "skip java 8 installation"
else
    echo "java 8 installation"
    apt-get install --yes python-software-properties >/dev/null 2>&1
    add-apt-repository ppa:webupd8team/java >/dev/null 2>&1
    apt-get update -qq >/dev/null 2>&1
    echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections >/dev/null 2>&1
    echo debconf shared/accepted-oracle-license-v1-1 seen true | /usr/bin/debconf-set-selections >/dev/null 2>&1
    apt-get install --yes oracle-java8-installer >/dev/null 2>&1
    yes "" | apt-get -f install >/dev/null 2>&1
fi