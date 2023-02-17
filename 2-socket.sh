printf "step: rm\n"
rm -f /tmp/firecracker.socket

printf "step: firecracker\n"
./firecracker --api-sock /tmp/firecracker.socket