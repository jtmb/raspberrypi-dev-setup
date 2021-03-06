#!bin/bash

# # Install Prerequisties
# echo Installing Prerequisties..
# echo Installing Docker...
# sudo apt install docker

echo Installing IProute2 and creating local variables...
sudo apt -y install iproute2

# Create local IP variable and bind to show default local interface IP
mylocalip=$(sudo ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
# Create Public IP variable and bind to show default Public IP
mypublicip=$(curl https://ipinfo.io/ip)


# remove old docker image if present
sudo docker rm -f nextcloud
# Pulls docker image
sudo docker pull nextcloud
# Runs Installs Docker image
# sudo docker run -d -p 4443:4443 -p 8443:443 -p 8092:80 -v /home/james/plex/plexmedia/nextcloud:/data --name nextcloudpi nextcloud $DOMAIN

 docker run -d \
    -v /home/james/container-program-files/nextcloud/nextcloudroot:/var/www/html \
    -v /home/james/container-program-files/nextcloud/nextcloud/apps:/var/www/html/custom_apps \
    -v /home/james/container-program-files/nextcloud/nextcloud/config:/var/www/html/config \
    -v /home/james/container-program-files/nextcloud/nextcloud/data:/var/www/html/data \
    -v /home/james/container-program-files/nextcloud/nextcloud_files:/data \
    -p 8443:443 \
    -p 80:80 \
    --name nextcloud \
    nextcloud \

#Set Nextcloud docker instance to restart automatic on system reboot
sudo docker update --restart unless-stopped nextcloud
sudo docker exec -it nextcloud apt update && apt install fail2ban -y

# provision PHP

sudo docker exec -it nextcloud RUN apt-get update && apt-get install -y libxml2-dev && docker-php-ext-install soap



echo Finished!
