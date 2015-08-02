#!/bin/sh
ARCHIVEHOME=${HOME}/GTALUG/backups/DokuWiki/data
DOKUWIKI_HOME=/srv/www/org_gtalug_wiki/html
mkdir -p ${ARCHIVEHOME}
cd ${ARCHIVEHOME}
git fetch origin
git pull origin master

scp -r ${USER}@penguin.gtalug.org:${DOKUWIKI_HOME}/data/pages ${ARCHIVEHOME}
scp -r ${USER}@penguin.gtalug.org:${DOKUWIKI_HOME}/data/meta ${ARCHIVEHOME}
scp -r ${USER}@penguin.gtalug.org:${DOKUWIKI_HOME}/data/media ${ARCHIVEHOME}
scp -r ${USER}@penguin.gtalug.org:${DOKUWIKI_HOME}/data/media_attic ${ARCHIVEHOME}
scp -r ${USER}@penguin.gtalug.org:${DOKUWIKI_HOME}/data/media_meta ${ARCHIVEHOME}
scp -r ${USER}@penguin.gtalug.org:${DOKUWIKI_HOME}/data/attic ${ARCHIVEHOME}
git add pages meta media media_attic media_meta attic
git commit -m "scripts/backup-dokuwiki-data.sh automated checkin"
git push origin master
