#!/bin/bash

grep -q -F 'daemon off;' /etc/nginx/nginx.conf || echo "daemon off;" >> /etc/nginx/nginx.conf


echo "Switching user to user"
sudo -u user bash << eof

echo "Activating Tethys virtual env"
source /home/user/tethys/miniconda/bin/activate tethys

echo "Attempting to start db"
pg_ctl -U postgres -D "/home/user/tethys/psql/data" -l "/home/user/tethys/psql/logfile" start -o "-p 8081"

echo "Deactivating Tethys env"
. /home/user/tethys/miniconda/bin/deactivate tethys

echo "Switching user back to root"
exit
eof

while true 
do
	service supervisor restart
done
