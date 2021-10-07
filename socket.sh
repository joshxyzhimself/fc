

printf "\n\n>> >> rm -f /tmp/firecracker.socket\n"
rm -f /tmp/firecracker.socket


printf "\n\n>> >> ./firecracker --api-sock /tmp/firecracker.socket\n"
./firecracker --api-sock /tmp/firecracker.socket