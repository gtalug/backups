#!/bin/sh

##
# Save the list of installed packages,versions
##

ARCHIVEHOME=${HOME}/GTALUG/backups
mkdir -p ${ARCHIVEHOME}
cd ${ARCHIVEHOME}
git fetch origin
git pull origin master

ssh ${USER}@penguin.gtalug.org "dpkg --list | grep ^ii | awk '{print \$2,\$3}'" > ${ARCHIVEHOME}/packages
git add ${ARCHIVEHOME}/packages
git commit -m "scripts/${0} system package list was modified"
git push origin master