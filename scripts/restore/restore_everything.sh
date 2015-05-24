#!/bin/bash

###
# Restore some of the gtalug infrastructure in the cwd
###

restore_website(){
    WEBSITES_HOME=${HOME}/WebSites/org_gtalug_www
    RESTORE_DIR=${PWD}
    sudo apt-get install -y git

    git clone https://github.com/gtalug/website.git

    sudo apt-get install -y python-virtualenv node-less python-dev

    mkdir -p ${WEBSITES_HOME}

    cd ${WEBSITES_HOME}

    virtualenv env

    source env/bin/activate

    pip install fabric

    fab install

    fab run
}


## Run all procedures

restore_website
