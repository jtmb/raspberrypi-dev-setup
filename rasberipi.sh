#!bin/bash

# remove old docker image if present
sudo docker rm -f jenkins-server2

echo Installing rasberypi autoconfig.
sleep 3
echo Installing Jenkins

# Setup Jenkins Home Dir working folder
cd /home/james
mkdir jenkins_home

sudo docker pull mlucken/jenkins-arm

sudo docker run -d --name jenkins-server2 -p 8090:8080 -p 50000:50000 -v /home/james/jenkins_home:/var/jenkins_home mlucken/jenkins-arm;

sudo docker start jenkins-server2

#Set Jebkins docker instance to restart automatic on system reboot
sudo docker update --restart unless-stopped jenkins-server2

echo
echo
echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo Jenkins URL: localhost:8090 or 192.168.0.19:8090
echo
echo Jenkins Password bellow!!
sudo docker exec -it jenkins-server2 cat /var/jenkins_home/secrets/initialAdminPassword
echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo
echo