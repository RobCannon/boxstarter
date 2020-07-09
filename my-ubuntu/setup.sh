# echo rcannon:pwd | chpasswd

echo ''
echo '------'
echo 'Copy .profile'
curl -L https://github.com/RobCannon/boxstarter/raw/master/profiles/ubuntu/.profile -o ~/.profile
echo ''

echo ''
echo '------'
echo 'Linking .shh keys'
if [ -d ~/.ssh ]; then
    rm -rf ~/.ssh
fi
ln -s $USERPROFILE/.ssh ~/.ssh
