sudo apt update -qq 2>&1 >/dev/null
sudo apt install -y -qq git vim tree net-tools telnet git python3-pip sshpass nfs-common 2>&1 >/dev/null
curl -fsSL https://get.docker.com -o  get-docker.sh 2>&1
sudo sh get-docker.sh 2>&1 >/dev/null
sudo usermod -aG docker vagrant
sudo service docker start
sudo echo "autocmd filetype yaml setlocal ai ts=2 et " > /home/vagrant/.vimrc
sed -i 's/ChallengeResponseAuthentification no/ChallengeResponseAuthentification yes/g' /etc/ssh/shh_config
sudo systemctl restart sshd