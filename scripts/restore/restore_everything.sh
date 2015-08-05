#!/bin/bash

###
# Restore some of the gtalug infrastructure in the cwd
###

restore_website(){

    sudo apt-get install -y git

    git clone https://github.com/gtalug/website.git

    sudo apt-get install -y -t wheezy-backports python-virtualenv node-less python-dev

    cd website

    virtualenv env

    source env/bin/activate

    pip install fabric

    fab install

    fab run
}


## Run all procedures

restore_website
