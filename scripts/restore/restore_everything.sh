#!/bin/bash

###
# Restore some of the gtalug infrastructure in the cwd
###

restore_website(){
    WEBSITES_HOME=${HOME}/WebSites
    RESTORE_DIR=${PWD}
    declare -A websites
    websites['org_gtalug_www']='https://github.com/gtalug/website.git'
    websites['org_gtalug_board']='git@github.com:gtalug/board-meetings.git'

    sudo apt-get install -y git python-virtualenv node-less python-dev \
    libyaml-dev bundler jekyll
    for key in ${!websites[@]}
    do
        mkdir -p ${WEBSITES_HOME}
        git clone ${websites[${key}]}  ${WEBSITES_HOME}/${key}
        cd ${WEBSITES_HOME}/${key}
        virtualenv env
        source env/bin/activate
        pip install fabric

        if [ -f requirements.txt ]
        then
            fab install
            fab run &
        else
            pip install PyYAML
            fab build
            fab run &
        fi
        deactivate

    done
}

restore_packages() {
    for pkg in $(cut -f1 -d' ' ../../packages)
    do
        # because of penguin has old packages from wheezy
        # installing individual packages is prefeered
        # this is much slower but works
        sudo apt-get -y install $pkg
    done
}

## Run all procedures

restore_website
restore_packages
