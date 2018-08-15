# Set up symlinks to share files across computers
sudo chown $USER ~/.config
rm ~/.profile & ln -s /c/Users/$USER/OneDrive/Documents/Keep/Linux/.profile ~/.profile
rm ~/.bashrc & ln -s /c/Users/$USER/OneDrive/Documents/Keep/Linux/.bashrc ~/.bashrc
rm ~/.ssh
mkdir ~/.ssh
cp /c/Users/$USER/OneDrive/Documents/Keep/Linux/.ssh/* ~/.ssh
sudo chmod 700 ~/.ssh
sudo chmod 600 ~/.ssh/id_rsa
sudo chmod 600 ~/.ssh/id_rsa.pub

# Prereqs for Microsoft tool installs
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | \
    sudo tee /etc/apt/sources.list.d/azure-cli.list
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
curl -L https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo curl -o /etc/apt/sources.list.d/microsoft.list https://packages.microsoft.com/config/ubuntu/16.04/prod.list

sudo apt-get install -y apt-transport-https
sudo apt-get update

sudo apt-get install -y unzip docker.io python3 python-pip nodejs zsh powershell

# Install docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose


#sudo pip install --upgrade pip

# Install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
mkdir ~/.kube & rm ~/.kube/config & ln -s /c/Users/$USER/OneDrive/Documents/Keep/Linux/.kube/config ~/.kube/config
rm -rf ~/.kube/configs & ln -s /c/Users/$USER/OneDrive/Documents/Keep/Linux/.kube/configs ~/.kube/configs

# Install Angular-cli
sudo npm install -g @angular/cli

# Install aws client
pip install awscli --user
rm -rf ~/.aws & ln -s /c/Users/$USER/OneDrive/Documents/Keep/Linux/.aws ~/.aws

# Install samld
#pip install samlkeygen --user

# Install terraform
wget https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip
unzip terraform_0.11.7_linux_amd64.zip
rm terraform_0.11.7_linux_amd64.zip
sudo mv terraform /usr/local/bin/

# Install azure-cli
sudo apt-get install azure-cli


# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sudo git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
rm -rf ~/.zshrc
ln -s /c/Users/$USER/OneDrive/Documents/Keep/Linux/.zshrc ~/.zshrc
