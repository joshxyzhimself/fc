# strict mode
printf "\n\n>> >> STRICT MODE..\n"
set -eu


# path vars
printf "\n\n>> >> PATHS..\n"
kernel_path="$(pwd)/vmlinux.bin"
rootfs_path="$(pwd)/bionic.rootfs.ext4"
echo "kernel_path $kernel_path"
echo "rootfs_path $rootfs_path"


# set guest kernel
printf "\n\n>> >> SET GUEST KERNEL..\n"
curl --unix-socket /tmp/firecracker.socket -i \
  -X PUT 'http://localhost/boot-source' \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -d "{
    \"kernel_image_path\": \"${kernel_path}\",
    \"boot_args\": \"reboot=k panic=1 pci=off nomodules\"
  }"


# set guest rootfs
printf "\n\n>> >> SET GUEST ROOTFS..\n"
curl --unix-socket /tmp/firecracker.socket -i \
  -X PUT 'http://localhost/drives/rootfs' \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -d "{
    \"drive_id\": \"rootfs\",
    \"path_on_host\": \"${rootfs_path}\",
    \"is_root_device\": true,
    \"is_read_only\": false
  }"


# start the guest machine
printf "\n\n>> >> START GUEST MACHINE..\n"
curl --unix-socket /tmp/firecracker.socket -i \
  -X PUT 'http://localhost/actions' \
  -H  'Accept: application/json'    \
  -H  'Content-Type: application/json'  \
  -d "{
    \"action_type\": \"InstanceStart\"
  }"