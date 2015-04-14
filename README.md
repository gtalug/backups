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

Restore gtalug.org and run it in developer mode

    $ cd scripts/restore
    $ ./restore_everything.sh

# Creating Backups

You need access to gtalug server and write access to gtalug/backups repository.

If you do not have access to gtalug repository, you can either fork the existing repository on github or create your own mirror. If you choose to do this, modify .git/config file, updating remote origin line.

Then you can run backups with the following command.

    $ cd scripts
    $ for k in *.sh; do ./{$k}; done

