wget -N https://github.com/firecracker-microvm/firecracker/releases/download/v0.24.6/firecracker-v0.24.6-x86_64.tgz

tar zxvf ./firecracker-v0.24.6-x86_64.tgz

cp ./release-v0.24.6/firecracker-v0.24.6-x86_64 /bin/fcx
cp ./release-v0.24.6/jailer-v0.24.6-x86_64 /bin/fcj

rm -rf ./firecracker-v0.24.6-x86_64.tgz
rm -rf ./release-v0.24.6/

fcx --version
fcj --version