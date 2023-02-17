kernel_path="./vmlinux.bin"
echo "kernel_path $kernel_path"

rootfs_path="./bionic.rootfs.ext4"
echo "rootfs_path $rootfs_path"

# set the guest kernel
curl --unix-socket /tmp/firecracker.socket -i \
  -X PUT 'http://localhost/boot-source' \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -d "{
    \"kernel_image_path\": \"${kernel_path}\",
    \"boot_args\": \"console=ttyS0 reboot=k panic=1 pci=off nomodules\"
  }"

# set the guest rootfs
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
curl --unix-socket /tmp/firecracker.socket -i \
  -X PUT 'http://localhost/actions' \
  -H  'Accept: application/json'    \
  -H  'Content-Type: application/json'  \
  -d "{
    \"action_type\": \"InstanceStart\"
  }"