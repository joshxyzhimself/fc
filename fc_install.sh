# strict mode
printf "\n\n>> >> STRICT MODE..\n"
set -eu


# nested vm check
printf "\n\n>> >> NESTED VM CHECK..\n"
apt install -y cpu-checker
kvm-ok


# install docker
printf "\n\n>> >> INSTALL DOCKER..\n"
apt update
apt install -y docker.io
systemctl start docker
usermod -aG docker $USER
systemctl status docker --no-pager


# kvm read-write access
printf "\n\n>> >> KVM READ-WRITE ACCESS..\n"
apt install -y acl
setfacl -m u:${USER}:rw /dev/kvm


# firecracker download
printf "\n\n>> >> FIRECRACKER DOWNLOAD..\n"
wget -N https://github.com/firecracker-microvm/firecracker/releases/download/v1.0.0/firecracker-v1.0.0-x86_64.tgz


# extract
printf "\n\n>> >> FIRECRACKER EXTRACT..\n"
tar zxvf ./firecracker-v1.0.0-x86_64.tgz


# executable
printf "\n\n>> >> FIRECRACKER EXECUTABLE..\n"
mv ./release-v1.0.0-x86_64/firecracker-v1.0.0-x86_64 ./firecracker
mv ./release-v1.0.0-x86_64/jailer-v1.0.0-x86_64 ./jailer


# permissions
printf "\n\n>> >> FIRECRACKER PERMISSIONS..\n"
chmod +x ./firecracker
chmod +x ./jailer


# version checks
printf "\n\n>> >> VERSION CHECKS..\n"
./firecracker --version
./jailer --version


# download kernel
printf "\n\n>> >> DOWNLOAD KERNEL..\n"
wget https://s3.amazonaws.com/spec.ccfc.min/img/quickstart_guide/x86_64/kernels/vmlinux.bin -N


# download rootfs
printf "\n\n>> >> DOWNLOAD ROOTFS..\n"
wget https://s3.amazonaws.com/spec.ccfc.min/img/quickstart_guide/x86_64/rootfs/bionic.rootfs.ext4 -N


# path vars
printf "\n\n>> >> PATHS..\n"
kernel_path="$(pwd)/vmlinux.bin"
rootfs_path="$(pwd)/bionic.rootfs.ext4"
echo "kernel_path $kernel_path"
echo "rootfs_path $rootfs_path"
