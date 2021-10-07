
# strict mode
printf "\n\n>> >> STRICT MODE..\n"
set -eu


# path vars
printf "\n\n>> >> PATHS..\n"
kernel_path="$(pwd)/vmlinux.bin"
rootfs_path="$(pwd)/bionic.rootfs.ext4"
echo "kernel_path $kernel_path"
echo "rootfs_path $rootfs_path"


# create vmconfig.json
printf "\n\n>> >> create vmconfig.json..\n"
cat <<EOF > vmconfig.json
{
  "boot-source": {
    "kernel_image_path": "$kernel_path",
    "boot_args": "console=ttyS0 reboot=k panic=1 pci=off nomodules"
  },
  "drives": [
    {
      "drive_id": "rootfs",
      "path_on_host": "$rootfs_path",
      "is_root_device": true,
      "is_read_only": false
    }
  ],
  "machine-config": {
    "vcpu_count": 2,
    "mem_size_mib": 1024,
    "ht_enabled": false
  }
}
EOF


# start firecracker
printf "\n\n>> >> start firecracker..\n"
./firecracker --no-api --config-file ./vmconfig.json