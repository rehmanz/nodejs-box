#!/bin/bash -e


salt_dep_file=~/.salt_dependencies.done
if [ ! -e ${salt_dep_file} ]; then
    echo "Installing SaltStack \"carbon\" release dependencies"
    sudo apt-get install -y python-setuptools python-dev build-essential tree
    sudo easy_install pip
    sudo pip install tornado
    touch ${salt_dep_file}
fi