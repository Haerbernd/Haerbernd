#!/bin/sh

if [ "$(id -u)" = "0" ]; then
  echo "You can't execute this script as root (or with sudo)! Please run it as user"
  exit 1
fi

sudo apt update
sudo apt upgrade
sudo apt autoremove

sudo apt install build-essential ufw nginx

# Create easy update script
cat >> ~/update.sh << 'EOF'
#!/bin/sh

sudo apt update
sudo apt upgrade
sudo apt autoremove
EOF
chmod +x ~/update.sh

### Docker Installation ###
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
