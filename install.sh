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

# path vars
kernel_path="$(pwd)/vmlinux.bin"
rootfs_path="$(pwd)/bionic.rootfs.ext4"

# path logs
echo "kernel_path $kernel_path"
echo "rootfs_path $rootfs_path"