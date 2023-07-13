
echo "## 1"
sudo apt update -qq 2>&1 >/dev/null

echo "## 2"
sudo apt install -y -qq git vim tree net-tools telnet git python3-pip sshpass nfs-common 2>&1 >/dev/null

echo "## 3"
curl -fsSL https://get.docker.com -o  get-docker.sh 2>&1

echo "## 3"
sudo sh get-docker.sh 2>&1 >/dev/null

echo "## 4"
sudo usermod -aG docker vagrant

echo "## 5"
sudo service docker start

sudo echo "autocmd filetype yaml setlocal ai ts=2 et " > /home/vagrant/.vimrc

echo "## 7"
sed -i 's/ChallengeResponseAuthentification no/ChallengeResponseAuthentification yes/g' /etc/ssh/shh_config

echo "## 8"
sudo systemctl restart sshd