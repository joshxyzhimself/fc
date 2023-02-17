
platform="x86_64"
printf "platform: $platform\n"

version="v1.2.0"
printf "version: $version\n"

printf "step: mkdir\n"
mkdir -p ./temp

printf "step: curl firecracker-$version-$platform\n"
curl --silent --location https://github.com/firecracker-microvm/firecracker/releases/download/$version/firecracker-$version-$platform.tgz > ./firecracker.tgz

printf "step: tar\n"
tar --gunzip --extract --file ./firecracker.tgz --directory ./temp

printf "step: mv\n"
mv ./release-$version-$platform/firecracker-$version-$platform ./firecracker
mv ./release-$version-$platform/jailer-$version-$platform ./jailer

printf "step: rm\n"
rm -rf ./release-$version-$platform/
rm -rf ./firecracker.tgz

printf "step: chmod\n"
chmod +x ./firecracker
chmod +x ./jailer

printf "step: curl kernel\n"
curl --location https://s3.amazonaws.com/spec.ccfc.min/img/quickstart_guide/x86_64/kernels/vmlinux.bin > ./vmlinux.bin

printf "step: curl rootfs\n"
curl --location https://s3.amazonaws.com/spec.ccfc.min/img/quickstart_guide/x86_64/rootfs/bionic.rootfs.ext4 > ./bionic.rootfs.ext4

kernel_path="./vmlinux.bin"
printf "kernel_path: $kernel_path\n"

rootfs_path="./bionic.rootfs.ext4"
printf "rootfs_path: $rootfs_path\n"
