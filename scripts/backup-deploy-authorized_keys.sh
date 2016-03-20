#!/bin/sh
ARCHIVEHOME=${HOME}/GTALUG/backups
mkdir -p ${ARCHIVEHOME}
cd ${ARCHIVEHOME}
git fetch origin
git pull origin master

scp -r ${USER}@penguin.gtalug.org:/home/deploy/.ssh/authorized_keys ${ARCHIVEHOME}/deploy-authorized_keys
git add ${ARCHIVEHOME}/deploy-authorized_keys
git commit -m "scripts/backup-deploy-authorized_keys.sh automated checkin"
git push origin master
