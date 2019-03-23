#!/usr/bin/env bash

cd $(dirname $(readlink -f "$0"))

function install_package() {
    package=( python ansible )
    
    for item in ${package[@]};
    do
        sudo dnf install ${item} -y
    done
}

function run_playbook() {
    playbook=( deploy-common deploy-user )
    
    for item in ${playbook[@]};
    do
        ansible-playbook playbook/${item}.yml
    done
}


echo "Are you Haven modified playbook/group_vars/all?(Y/N)"
read isOk

if [[ ${isOk} = "Y" ]]; then
    install_package
    run_playbook
else
    echo "Please Modify playbook/group_vars/all"
fi
