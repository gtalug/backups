#!/bin/sh
ARCHIVEHOME=${HOME}/GTALUG/backups/GTALUG-Mail-Archives
mkdir -p $ARCHIVEHOME
cd $ARCHIVEHOME
git fetch origin
git pull origin master

# Set up password for Mailman
MAILMANPASSFILE=${MAILMANPASSFILE:-"${HOME}/GitConfig/InitFiles/GTALUG/GTALUG-mailman-password"}

MAILMANSUBTOOL=${MAILMANSUBTOOL:-"${HOME}/GitStuff/mailman-subscribers/mailman-subscribers.py"}

GPGKEYS=${GPGKEYS:-"6AA6A713 5A2FE7BF"}

for list in announce operations talk; do
    listname=${list}
    listfile=${ARCHIVEHOME}/${listname}/subscribers.asc
    templocation=`mktemp`
    echo "Grabbing subscribers of Slony list ${listname} into data file: [${templocation}]"
    python ${MAILMANSUBTOOL} -o ${templocation} --password-file=${MAILMANPASSFILE} gtalug.org ${listname} 
    echo "Encrypt [${templocation}] into [${listfile}] for GPG user list ${GPGKEYS}"
    gpg --encrypt --armor -r "${GPGKEYS}" --batch --yes --trust-model always -o ${listfile} ${templocation}
    rm -f ${templocation}
    git add ${listfile}
done

git commit -m "Check in mailing list subscribers - run of scripts/Slony-Archive-Mail-Subscribers.sh"
git push origin master
