
sudo docker rm -f ghost


sudo docker run -d --name ghost -e url=https://blog.branconet.com -p 8081:2368 -v /home/james/container-program-files/ghost-blog:/var/lib/ghost/content ghost:alpine