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

# version checks
fcx --version
fcj --version

# nested virtualization check
apt install -y cpu-checker
kvm-ok

# download
wget https://s3.amazonaws.com/spec.ccfc.min/img/quickstart_guide/x86_64/kernels/vmlinux.bin -N
wget https://s3.amazonaws.com/spec.ccfc.min/img/quickstart_guide/x86_64/rootfs/bionic.rootfs.ext4 -N

# rename
mv ./vmlinux.bin ./hello-vmlinux.bin
mv ./bionic.rootfs.ext4 ./hello-rootfs.ext4