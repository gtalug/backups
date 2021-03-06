#!/bin/sh
ARCHIVEHOME=${HOME}/GTALUG/backups
mkdir -p ${ARCHIVEHOME}
cd ${ARCHIVEHOME}
git fetch origin
git pull origin master

scp -r ${USER}@penguin.gtalug.org:/etc/postfix ${ARCHIVEHOME}
git add ${ARCHIVEHOME}
git commit -m "scripts/backup-postfix-config.sh automated checkin"
git push origin master
