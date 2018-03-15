FROM debian:jessie

#Non-root user setup
RUN apt-get update && apt-get install -y sudo && \
	adduser --disabled-password --gecos "" user && \
	echo "user ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/user && \
	chmod 0440 /etc/sudoers.d/user

RUN su - user -c "touch me"

#Switch to non-root user
USER user

#Install basic packages
RUN sudo apt-get update && sudo apt-get install -y \
	wget \
	vim \
	lsb-release\
	python \
	python-dev \
	python-pip \
	git \
	supervisor

#Tethys installation
RUN sudo wget https://raw.githubusercontent.com/tethysplatform/tethys/release/scripts/install_tethys.sh
RUN bash install_tethys.sh --allowed-host 127.0.0.1 --db-username dbuser --db-password dbpassword --db-port 8081 --superuser admin --superuser-pass password --production

#supervisor setup
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY tethysuwsgi.sh /etc/supervisor/tethysuwsgi.sh

#startup script to setup nginx server, start tethys db & start supervisor
COPY startup.sh /startup.sh

#script that installs a Tethys app from a github link
COPY installApp.sh /installApp.sh

#switch back to root user and run startup script
USER root
CMD ["/bin/bash", "/startup.sh"]
