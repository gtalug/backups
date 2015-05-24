#!/bin/bash

###
# Restore some of the gtalug infrastructure in the cwd
###

restore_website(){
    WEBSITES_HOME=${HOME}/WebSites/
    RESTORE_DIR=${PWD}
    sudo apt-get install -y git

    git clone https://github.com/gtalug/website.git

    sudo apt-get install -y python-virtualenv node-less python-dev
    for website in org_gtalug_www org_gtalug_board
    do
        mkdir -p ${WEBSITES_HOME}/${website}
        cd ${WEBSITES_HOME}/${webiste}
        virtualenv env
        source env/bin/activate
        [ -f requirements.txt ] && pip install -r requirements.txt
        pip install fabric
        fab install
        fab run
    done
}


## Run all procedures

restore_website
