#!/bin/sh
ARCHIVEHOME=${HOME}/GTALUG/backups
mkdir -p ${ARCHIVEHOME}
cd ${ARCHIVEHOME}
git fetch origin
git pull origin master

scp -r chris@penguin.gtalug.org:/etc/iptables.firewall.rules ${ARCHIVEHOME}
git add ${ARCHIVEHOME}
git commit -m "scripts/backup-aliases-config.sh automated checkin"
git push origin master
