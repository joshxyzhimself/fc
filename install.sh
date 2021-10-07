set -eu

# download
wget -N https://github.com/firecracker-microvm/firecracker/releases/download/v0.24.6/firecracker-v0.24.6-x86_64.tgz

# extract
tar zxvf ./firecracker-v0.24.6-x86_64.tgz

# executable path
cp ./release-v0.24.6/firecracker-v0.24.6-x86_64 /bin/fcx
cp ./release-v0.24.6/jailer-v0.24.6-x86_64 /bin/fcj

# permissions
chmod +x /bin/fcx
chmod +x /bin/fcj

# cleanup
rm -rf ./firecracker-v0.24.6-x86_64.tgz
rm -rf ./release-v0.24.6/

# version checks
fcx --version
fcj --version