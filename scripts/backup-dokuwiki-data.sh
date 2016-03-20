#!/bin/bash
ARCHIVEHOME=${HOME}/GTALUG/backups/DokuWiki/data
DOKUWIKI_HOME=/srv/www/org_gtalug_wiki/html
DATA_DIR=(pages meta media media_attic media_meta attic)
mkdir -p ${ARCHIVEHOME}
cd ${ARCHIVEHOME}
git fetch origin
git pull origin master

for dir in "${DATA_DIR[@]}"
do
  scp -r ${USER}@penguin.gtalug.org:${DOKUWIKI_HOME}/data/$dir ${ARCHIVEHOME}
  scp ${USER}@penguin.gtalug.org:${DOKUWIKI_HOME}/data/$dir ${ARCHIVEHOME}
  git add $dir
done

git commit -m "scripts/backup-dokuwiki-data.sh automated checkin"
git push origin master
