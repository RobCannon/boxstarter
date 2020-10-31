# source <(curl -s https://raw.githubusercontent.com/RobCannon/boxstarter/master/boxstarter.sh)

DEBIAN_FRONTEND=noninteractive
sudo -v


# Set up symlinks to share files across computers
echo ''
echo '------'
echo 'Copy .profile'
curl -L https://raw.githubusercontent.com/RobCannon/boxstarter/master/profiles/ubuntu/.bashrc -o ~/.bashrc
mkdir -p ~/.oh-my-posh
curl -L https://raw.githubusercontent.com/RobCannon/boxstarter/master/profiles/oh-my-posh/my-posh.json -o ~/.oh-my-posh/my-posh.json
echo ''


if [ -d $USERPROFILE/.ssh]; then
  echo ''
  echo '------'
  echo 'Linking .shh keys'
  if [ -d ~/.ssh ]; then
      rm -rf ~/.ssh
  fi
  ln -s $USERPROFILE/.ssh ~/.ssh
fi


echo ''
echo '------'
echo 'Setting package source and updating apt-get'
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https
sudo -v
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo -v
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
sudo -v
sudo DEBIAN_FRONTEND=noninteractive apt-get autoremove -y
sudo -v
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y curl unzip zip git
sudo -v


# Inspired by https://blog.anaisbetts.org/using-github-credentials-in-wsl2/
if [ -d $USERPROFILE/scoop/apps/git/current/mingw64/libexec/git-core ]
then
  echo $'#!/bin/sh\nexec $USERPROFILE/scoop/apps/git/current/mingw64/libexec/git-core/git-credential-manager.exe $@' > ~/git-credential-manager
  sudo mv ~/git-credential-manager /usr/bin/git-credential-manager
  sudo chmod +x /usr/bin/git-credential-manager
  git config --global credential.helper manager
else
  git config --global credential.helper store
fi

git config --global user.name "Rob Cannon"
git config --global user.email "rob@cannonsoftware.com"
git config --global core.autocrlf false
echo ''

sudo chown -R $USER ~/.config


echo ''
echo '------'
echo 'Installing nodejs'
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs
sudo -v
sudo npm install -g npm npm-check-updates tldr
sudo -v
echo ''


echo ''
echo '------'
echo 'Installing powershell'
# https://docs.microsoft.com/en-us/powershell/scripting/setup/installing-powershell-core-on-linux?view=powershell-6
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo -v
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y powershell
sudo -v
echo ''


echo ''
echo '------'
echo 'Installing docker'
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y docker.io
sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/bin/docker-compose
sudo chmod +x /usr/bin/docker-compose
echo ''


echo ''
echo '------'
echo 'Installing kubectl'
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/bin/kubectl
if [ -d $USERPROFILE/.kube ]
then
  if [ -f ~/.kube/config ]
  then
    sudo rm ~/.kube/config
  fi
  ln -s $USERPROFILE/.kube/config ~/.kube/config
fi
echo ''


echo ''
echo '------'
echo 'Installing helm'
curl -L https://git.io/get_helm.sh | bash
helm init --client-only
echo ''


echo ''
echo '------'
echo 'Installing terraform'
# https://github.com/hashicorp/terraform/releases
TERRAFORM_VERSION=0.13.5
TERRAFORM_FILE="terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
curl -LO https://releases.hashicorp.com/terraform/$TERRAFORM_VERSION/$TERRAFORM_FILE
unzip $TERRAFORM_FILE
rm $TERRAFORM_FILE
sudo mv terraform /usr/bin/
echo ''


echo ''
echo '------'
echo 'Installing azure-cli'
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | \
    sudo tee /etc/apt/sources.list.d/azure-cli.list
curl -L https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo curl -o /etc/apt/sources.list.d/microsoft.list https://packages.microsoft.com/config/ubuntu/16.04/prod.list
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo -v
sudo DEBIAN_FRONTEND=noninteractive apt-get install azure-cli
sudo -v
echo ''


echo ''
echo '------'
echo 'Installing dotnet'
# The first 4 lines are already done above, but repeated here for completeness
# wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
# sudo dpkg -i packages-microsoft-prod.deb
# sudo DEBIAN_FRONTEND=noninteractive apt-get install apt-transport-https
# sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y dotnet-sdk-3.1
sudo -v
sudo dotnet tool install --global dotnet-outdated
echo ''


echo ''
echo '------'
echo 'Installing powerline-go for custom prompt'
sudo -v
curl -L https://github.com/JanDeDobbeleer/oh-my-posh3/releases/latest/download/posh-linux-amd64 --output ~/oh-my-posh
chmod +x ~/oh-my-posh
sudo mv ~/oh-my-posh /usr/bin/oh-my-posh


echo ''
echo '------'
echo 'Upgrading packages'
sudo -v
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo -v
sudo DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
sudo -v
sudo DEBIAN_FRONTEND=noninteractive apt-get -y autoremove
sudo -v
sudo DEBIAN_FRONTEND=noninteractive apt-get -y autoclean
echo ''
