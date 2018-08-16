# Set up symlinks to share files across computers
#sudo chown $USER ~/.config
echo ''
echo '------'
echo 'Smymlink for .profile'
if [ -f ~/.profile ]; then
  rm ~/.profile
fi
ln -s /c/Users/$USER/OneDrive/Documents/Keep/Linux/.profile ~/.profile
echo ''

echo ''
echo '------'
echo 'Symlink for .bashrc '
if [ -f ~/.bashrc ]; then
  rm ~/.bashrc
fi
ln -s /c/Users/$USER/OneDrive/Documents/Keep/Linux/.bashrc ~/.bashrc
echo ''

echo ''
echo '------'
echo 'Copying .shh keys'
rm -rf ~/.ssh
mkdir ~/.ssh
cp /c/Users/$USER/OneDrive/Documents/Keep/Linux/.ssh/* ~/.ssh
sudo chmod 700 ~/.ssh
sudo chmod 600 ~/.ssh/id_rsa
sudo chmod 600 ~/.ssh/id_rsa.pub
echo ''

echo ''
echo '------'
echo 'Setting package source and updating apt-get'
sudo apt-get install -y apt-transport-https
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get autoremove -y
sudo apt-get install -y curl unzip zip
echo ''

echo ''
echo '------'
echo 'Installing python'
sudo apt-get install -y python3 python-pip

echo ''
echo '------'
echo 'Installing nodejs'
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install -g npm
echo ''

echo ''
echo '------'
echo 'Installing docker'
sudo apt-get install -y docker.io
sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
echo ''

echo ''
echo '------'
echo 'Installing kubectl'
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
if [ ! -d ~/.kube ]; then
    mkdir ~/.kube
fi
if [ -f ~/.kube/config ]; then
  sudo rm ~/.kube/config
fi
if [ -d ~/.kube/configs ]; then
    sudo rm -rf ~/.kube/configs
fi
ln -s /c/Users/$USER/OneDrive/Documents/Keep/Linux/.kube/config ~/.kube/config
ln -s /c/Users/$USER/OneDrive/Documents/Keep/Linux/.kube/configs ~/.kube/configs
echo ''

echo ''
echo '------'
echo 'Installing @angular/cli'
sudo npm install -g @angular/cli
echo ''

echo ''
echo '------'
echo 'Installing aws client'
pip install awscli --user
if [ -d ~/.aws ]; then
  sudo rm -rf ~/.aws
fi
rm -rf ~/.aws & ln -s /c/Users/$USER/OneDrive/Documents/Keep/Linux/.aws ~/.aws
echo ''

echo ''
echo '------'
echo 'Installing terraform'
wget https://releases.hashicorp.com/terraform/0.11.8/terraform_0.11.8_linux_amd64.zip
unzip terraform_0.11.8_linux_amd64.zip
rm terraform_0.11.8_linux_amd64.zip
sudo mv terraform /usr/local/bin/
echo ''

echo ''
echo '------'
echo 'Installing azure-cli'
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | \
    sudo tee /etc/apt/sources.list.d/azure-cli.list
curl -L https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo curl -o /etc/apt/sources.list.d/microsoft.list https://packages.microsoft.com/config/ubuntu/16.04/prod.list
sudo apt-get update
sudo apt-get install azure-cli
echo ''

echo ''
echo '------'
echo 'Installing zsh'
sudo apt-get install -y zsh
if [ -f ~/.zshrc ]; then
  sudo rm ~/.zshrc
fi
ln -s /c/Users/$USER/OneDrive/Documents/Keep/Linux/.zshrc ~/.zshrc
echo ''

echo ''
echo '------'
echo 'Upgrading packages'
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get autoremove -y
echo ''

echo ''
echo '------'
echo 'Installing oh-my-zsh'
if [ -d ~/.oh-my-zsh ]; then
  sudo rm -rf ~/.oh-my-zsh
fi
umask g-w,o-w
env git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
export ZSH=~/.oh-my-zsh
sudo git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
chsh -s /usr/bin/zsh