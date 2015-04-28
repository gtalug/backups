#!/bin/sh
MAILMANSUBTOOL=${MAILMANSUBTOOL:-${PWD}/dependencies/mailman-subscribers.py}
ARCHIVEHOME=${HOME}/GTALUG/backups/GTALUG-Mail-Archives
mkdir -p $ARCHIVEHOME
cd $ARCHIVEHOME
git fetch origin
git pull origin master

# Set up password for Mailman
MAILMANPASSDIR=${MAILMANPASSFILE:-${HOME}/GitConfig/InitFiles/GTALUG/}
  # The passwords for mailing lists needs to be placed in
  # $MAILMANPASSDIR/announce, $MAILMANPASSDIR/operations, $MAILMANPASSDIR/talk
  # That obviously shouldn't be published in the git repo publicly, here.
  # See Mailman/mpass to find GPG'ed copy of passwords
###  Python tool: https://github.com/larsks/mailman-subscribers/blob/master/mailman-subscribers.py

GPGKEYS=${GPGKEYS:-"6AA6A713 5A2FE7BF D598FD34"}

for list in announce operations talk; do
    listname=${list}
    listfile=${ARCHIVEHOME}/${listname}/subscribers.asc
    templocation=`mktemp`
    echo "Grabbing subscribers of GTALUG list ${listname} into data file: [${templocation}]"
    python ${MAILMANSUBTOOL} -o ${templocation} --password-file=${MAILMANPASSDIR}/${list} gtalug.org ${listname}
    echo "Encrypt [${templocation}] into [${listfile}] for GPG user list ${GPGKEYS}"
    gpg --encrypt --armor -r "${GPGKEYS}" --batch --yes --trust-model always -o ${listfile} ${templocation}
    rm -f ${templocation}
    git add ${listfile}
done

git commit -m "Check in mailing list subscribers - run of scripts/archive-subscribers.sh"
git push origin master
