#!/bin/sh
ARCHIVEHOME=${HOME}/GTALUG/backups/Mailman
mkdir -p ${ARCHIVEHOME}
cd ${ARCHIVEHOME}
git fetch origin
git pull origin master

scp chris@penguin.gtalug.org:/etc/mailman/mm_cfg.py ${ARCHIVEHOME}
git add mm_cfg.py
git commit -m "scripts/backup-mailman-config.sh automated checkin"
git push origin master
