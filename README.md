backups
=======

This repo pulls backups of various sorts of GTALUG infrastructure.

# Setup

Create a directory called `GTALUG` in home and then clone backups subfolder.

    $ cd ${HOME}
    $ mkdir -p GTALUG
    $ cd GTALUG
    $ git clone https://github.com/gtalug/backups

# Restoring backups

Currently the script only restores gtalug.org site in developer mode

    $ cd scripts/restore
    $ ./restore_everything.sh

# Running Backups

You need access to gtalug server and write access to gtalug/backups repository.

If you do not have access to gtalug repository, you can either fork the existing repository on github or create your own mirror. If you choose to do this, modify .git/config file, updating remote origin line.

Then you can run backups with the following command.

    $ cd scripts
    $ for k in *.sh; do ./{$k}; done

# Adding gpg keys in archive-subscribers.sh

Searching for keys on keys.gnupg.net

Enter the following in `Search for keys` field

    0x6AA6A713
    0x5A2FE7BF
    0xD598FD34


The result should display the owner of each key.

## Receive the appropriate keys

    gpg --keyserver pgp.mit.edu --recv-keys 0x6AA6A713
    gpg --keyserver pgp.mit.edu --recv-keys 0x5A2FE7BF
    gpg --keyserver pgp.mit.edu --recv-keys 0xD598FD34

# Extract mailman passwords
 and run archive-subscribers.sh

Go to   `backups/Mailman/mmpass/` and extract encrypted data from `mailman-passwords.tar.bz2.asc`, you either need to be the owner of one of the keys mentioned in **Receive the appropriate keys** section, these are the keys used in encrypting `mailman-passwords.tar.bz2.asc`.

If you want your key added to the list, please email `operations@gtalug.org`

Use the following command to extract the keys:

    $ cd Mailman/mmpass
    $ gpg --output mailman-passwords.tar.bz2 --decrypt mailman-passwords.tar.bz2.asc
    $ tar xjf mailman-passwords.tar.bz2

# Export $MAILMANPASSFILE environmental variable

While you still in Mailman/mmpass directory, run the following command

    $ export MAILMANPASSFILE=${PWD}

Alternatively you can use full path to the repository

    $ export MAILMANPASSFILE=${HOME}/GTALUG/backups/Mailman/mmpass/

# Run the backups

    $ cd ../../scripts
    $ for k in *.sh; do ./${k}; done

