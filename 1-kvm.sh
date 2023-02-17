setfacl -m u:${USER}:rw /dev/kvm

[ $(stat -c "%G" /dev/kvm) = kvm ] && sudo usermod -aG kvm ${USER} && echo "Access granted."

[ -r /dev/kvm ] && [ -w /dev/kvm ] && echo "OK" || echo "FAIL"