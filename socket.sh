printf "step: rm\n"
rm -f /tmp/firecracker.socket

printf "step: firecracker\n"
./temp/firecracker --api-sock /tmp/firecracker.socket