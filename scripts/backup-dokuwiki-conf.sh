#!/bin/sh
ARCHIVEHOME=${HOME}/GTALUG/backups/DokuWiki/conf
DOKUWIKI_HOME=/srv/www/org_gtalug_wiki/html
CONF_FILES=(acl.auth.php acronyms.conf dokuwiki.php entities.conf interwiki.conf license.php local.php mediameta.php mime.conf plugins.local.php plugins.php plugins.required.php scheme.conf smileys.conf wordblock.conf)
mkdir -p ${ARCHIVEHOME}
cd ${ARCHIVEHOME}
git fetch origin
git pull origin master

for file in "${CONF_FILES[@]}"
do
  scp ${USER}@penguin.gtalug.org:${DOKUWIKI_HOME}/conf/$file ${ARCHIVEHOME}
  git add $file
done

TEMP_FILE = `mktemp`

GPGKEYS=${GPGKEYS:-"6AA6A713 5A2FE7BF D598FD34"}

GPG_RECIPIENTS=""

for gpgkey in GPGKEYS
do
    GPG_RECIPIENTS="${GPG_RECIPIENT} --recipient ${gpgkey}"
done

scp ${USER}@penguin.gtalug.org:${DOKUWIKI_HOME}/conf/users.auth.php ${TEMP_FILE}
gpg --encrypt --armor ${GPG_RECIPIENTS} --batch --yes --trust-model always -o ${DOKUWIKI_HOME}/conf/users.auth.php.asc ${TEMP_FILE}
rm -f ${TEMP_FILE}
git add users.auth.php.asc

git commit -m "scripts/backup-dokuwiki-conf.sh automated checkin"
git push origin master
