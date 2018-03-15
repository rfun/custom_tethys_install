#!/bin/bash

export TETHYS_HOME='/home/user/tethys'

cd home/user/tethys/apps/

echo "Cloning Repo from $1 to home/user/tethys/apps/$2"
git clone $1 $2

cd $2/

echo "Activating Tethys virtual env"
source /home/user/tethys/miniconda/bin/activate tethys

echo "Installing application"
python setup.py install

echo "Collecting Static files"
tethys manage collectstatic << STDIN
yes
STDIN


echo "Switching user to user"
sudo -u user bash << eof

echo "Activating Tethys virtual env"
source /home/user/tethys/miniconda/bin/activate tethys

#tethys_user_own
sudo chown -R ${USER} "${TETHYS_HOME}/src" "${TETHYS_HOME}/static" "${TETHYS_HOME}/workspaces" "${TETHYS_HOME}/apps"

echo "Deactivating Tethys env"
. /home/user/tethys/miniconda/bin/deactivate tethys

echo "Switching user back to root"
exit
eof

service supervisor stop

