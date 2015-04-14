#!/bin/sh
ARCHIVEHOME=${HOME}/GTALUG/backups
mkdir -p ${ARCHIVEHOME}
cd ${ARCHIVEHOME}
git fetch origin
git pull origin master

scp -r ${USER}@penguin.gtalug.org:/etc/apache2 ${ARCHIVEHOME}
git add ${ARCHIVEHOME}
git commit -m "scripts/backup-apache2-config.sh automated checkin"
git push origin master
