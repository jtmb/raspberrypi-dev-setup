docker pull vaultwarden/server:latest
docker run -d --name vaultwarden -v /home/james/container-program-files/vault_warden:/data/ -p 8096:80 vaultwarden/server:latest
sudo docker update --restart unless-stopped vaultwarden

echo finished! :8096