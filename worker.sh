sudo apt install curl
sudo curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up

sudo apt install linux-headers-amd64
wget https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt-get update
sudo apt install cuda-drivers
