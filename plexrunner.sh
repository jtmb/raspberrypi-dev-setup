#!bin/bash

# system host prereqs
sudo apt-get install libffi-dev libssl-dev
sudo apt install python3-dev
sudo apt-get install -y python3 python3-pip  
sudo pip3 install docker-compose

# Create local IP variable and bind to show default local interface IP
mylocalip=$(sudo ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)

cd /home/james/container-program-files/ && sudo mkdir plex
sudo chmod 777 plex
cd plex
sudo mkdir database; sudo mkdir transcode; sudo mkdir plexmedia; cd plexmedia
cd

# Pull/Run container
sudo docker pull linuxserver/plex
# remove old images
sudo docker rm -f plex

sudo docker run -d \
  --name=plex \
  --net=host \
  -e PUID=1000 \
  -e PGID=1000 \
  -e VERSION=docker \
  -v /home/james/container-program-files/plex/database:/config \
  -v /home/james/container-program-files/plex/transcode:/transcode \
  -v /home/james/container-program-files/fileserver_share_files/plex_files:/data \
  -e TZ="America/Toronto" \
  -e ADVERTISE_IP="http://192.168.0.23:32400/" \
  --restart unless-stopped \
  linuxserver/plex

sudo docker exec -it plex apt update && apt install fail2ban -y

echo
echo
echo ----------------- Plex URLS---------------------------
echo
echo Local Address: "$mylocalip:32400/manage"
echo
echo -------------------------------------------------------------------
echo
echo
echo Finished!

# sudo mount /dev/sda1 /home/james/plex/plexmedia/WD1TB

sudo ufw allow 32400/tcp
sudo ufw allow 32400/udp

