
platform="x86_64"
printf "platform: $platform\n"

version="v1.0.0"
printf "version: $version\n"

printf "step: mkdir\n"
mkdir -p ./temp

printf "step: curl firecracker-$version-$platform\n"
curl --silent --location https://github.com/firecracker-microvm/firecracker/releases/download/$version/firecracker-$version-$platform.tgz > ./temp/firecracker.tgz

printf "step: tar\n"
tar --gunzip --extract --file ./temp/firecracker.tgz --directory ./temp

printf "step: mv\n"
mv ./temp/release-$version-$platform/firecracker-$version-$platform ./temp/firecracker
mv ./temp/release-$version-$platform/jailer-$version-$platform ./temp/jailer

printf "step: rm\n"
rm -rf ./temp/release-$version-$platform/
rm -rf ./temp/firecracker.tgz

printf "step: chmod\n"
chmod +x ./temp/firecracker
chmod +x ./temp/jailer

printf "step: curl kernel\n"
curl --location https://s3.amazonaws.com/spec.ccfc.min/img/quickstart_guide/x86_64/kernels/vmlinux.bin > ./temp/vmlinux.bin

printf "step: curl rootfs\n"
curl --location https://s3.amazonaws.com/spec.ccfc.min/img/quickstart_guide/x86_64/rootfs/bionic.rootfs.ext4 > ./temp/bionic.rootfs.ext4

kernel_path="./temp/vmlinux.bin"
printf "kernel_path: $kernel_path\n"

rootfs_path="./temp/bionic.rootfs.ext4"
printf "rootfs_path: $rootfs_path\n"
