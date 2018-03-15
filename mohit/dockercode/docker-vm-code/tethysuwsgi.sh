mkdir -p /run/uwsgi; chown www-data:www-data /run/uwsgi
/home/user/tethys/miniconda/envs/tethys/bin/uwsgi --yaml /home/user/tethys/src/tethys_portal/tethys_uwsgi.yml --uid www-data --gid www-data
chown -R www-data:www-data /run/uwsgi

