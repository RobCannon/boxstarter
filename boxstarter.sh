DEBIAN_FRONTEND=noninteractive

# Set up symlinks to share files across computers
echo ''
echo '------'
echo 'Copy .profile'
curl -L https://github.com/RobCannon/boxstarter/raw/master/ubuntu/.profile -o ~/.profile
echo ''

echo ''
echo '------'
echo 'Copy .bashrc '
curl -L https://github.com/RobCannon/boxstarter/raw/master/ubuntu/.bashrc -o ~/.bashrc
echo ''

# echo ''
# echo '------'
# echo 'Copying .shh keys'
# rm -rf ~/.ssh
# mkdir ~/.ssh
# cp /c/Users/$USER/OneDrive/Documents/Keep/Linux/.ssh/* ~/.ssh
# sudo chmod 700 ~/.ssh
# sudo chmod 600 ~/.ssh/id_rsa
# sudo chmod 600 ~/.ssh/id_rsa.pub
# echo ''

echo ''
echo '------'
echo 'Setting package source and updating apt-get'
sudo apt-get install -y apt-transport-https
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get autoremove -y
sudo apt-get install -y curl unzip zip git
git config --global credential.helper store
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
sudo npm install -g npm npm-check-updates tldr
echo ''

echo ''
echo '------'
echo 'Installing powershell'
# https://docs.microsoft.com/en-us/powershell/scripting/setup/installing-powershell-core-on-linux?view=powershell-6
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get install -y powershell
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
# if [ -f ~/.kube/config ]; then
#   sudo rm ~/.kube/config
# fi
# if [ -d ~/.kube/configs ]; then
#     sudo rm -rf ~/.kube/configs
# fi
# ln -s /c/Users/$USER/OneDrive/Documents/Keep/Linux/.kube/config ~/.kube/config
# ln -s /c/Users/$USER/OneDrive/Documents/Keep/Linux/.kube/configs ~/.kube/configs
echo ''

echo ''
echo '------'
echo 'Installing helm'
curl -L https://git.io/get_helm.sh | bash
helm init --client-only
echo ''

echo ''
echo '------'
echo 'Installing @angular/cli'
sudo npm install -g @angular/cli
echo ''

# echo ''
# echo '------'
# echo 'Installing aws client'
# pip install awscli --user
# # if [ -d ~/.aws ]; then
# #   sudo rm -rf ~/.aws
# # fi
# # ln -s /c/Users/$USER/OneDrive/Documents/Keep/Linux/.aws ~/.aws
# echo ''

echo ''
echo '------'
echo 'Installing terraform'
TERRAFORM_VERSION=0.12.6
TERRAFORM_FILE="terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
curl -LO https://releases.hashicorp.com/terraform/$TERRAFORM_VERSION/$TERRAFORM_FILE
unzip $TERRAFORM_FILE
rm $TERRAFORM_FILE
sudo mv terraform /usr/local/bin/
echo ''

echo ''
echo '------'
echo 'Installing terraform-docs'
curl -L https://github.com/segmentio/terraform-docs/releases/download/v0.6.0/terraform-docs-v0.6.0-linux-amd64 -o ~/terraform-docs
chmod +x ~/terraform-docs
sudo mv ~/terraform-docs /usr/local/bin/

# echo ''
# echo '------'
# echo 'Installing ansible'
# sudo apt update
# sudo apt-get install python-dev libkrb5-dev krb5-user python-pip
# sudo pip install ansible pywinrm kerberos requests-kerberos requests-credssp --upgrade
# echo ''

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
echo 'Installing google-cloud-sdk'
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && sudo apt-get install google-cloud-sdk
echo ''

echo ''
echo '------'
echo 'Installing dotnet'
# The first 4 lines are already done above, but repeated here for completeness
# wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
# sudo dpkg -i packages-microsoft-prod.deb
# sudo apt-get install apt-transport-https
# sudo apt-get update
sudo apt-get install -y dotnet-sdk-2.2
sudo dotnet tool install --global dotnet-outdated
echo ''

# echo ''
# echo '------'
# echo 'Installing go'
# sudo add-apt-repository ppa:longsleep/golang-backports
# sudo apt-get update
# sudo apt-get install golang-go
# echo ''


echo ''
echo '------'
echo 'Installing pretty-ping'
curl -O https://raw.githubusercontent.com/denilsonsa/prettyping/master/prettyping
chmod +x prettyping
sudo mv prettyping /usr/local/bin/
echo ''


echo ''
echo '------'
echo 'Installing zsh'
sudo apt-get install -y zsh
if [ -f ~/.zshrc ]; then
  sudo rm ~/.zshrc
fi
curl -L https://github.com/RobCannon/boxstarter/raw/master/ubuntu/.zshrc -o ~/.zshrc
echo ''

echo ''
echo '------'
echo 'Upgrading packages'
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y autoremove
sudo apt-get -y autoclean
sudo chown -R $USER ~/.config
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
env git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
sudo chsh -s /usr/bin/zsh
zsh