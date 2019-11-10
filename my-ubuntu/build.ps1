docker build -t my-ubuntu .
docker run --name fs -it -d my-ubuntu
docker export --output my-ubuntu.tar fs
docker stop fs
docker rm fs
wsl --unregister my-ubuntu
wsl --import my-ubuntu "$env:APPDATA\my-ubuntu\" .\my-ubuntu.tar
wsl -d my-ubuntu -u root -- printf '[automount]\nroot = /\noptions = "metadata"' ^> /etc/wsl.conf
wsl -d my-ubuntu -u rob -- sh -c "`$(curl -fsSL https://github.com/RobCannon/boxstarter/raw/master/my-ubuntu/setup.sh)"
