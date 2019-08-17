expect  <<  EOF
	spawn clone-vm7
	expect "number:" {send "$1\r"}
	expect  "$" {send "exit\t"}
EOF
sudo virsh start tedu_node$1
sleep 20
expect << EOF
spawn sudo virsh console tedu_node$1
	expect "login:" {send "root\r"}
	expect "Password:" {send "123456\r"}
	expect "#" {send "hostnamectl set-hostname $4\r"}
	expect "#" {send "nmcli connection modify $2 ipv4.method manual ipv4.address $3/24 connection.autoconnect yes\r"}
	expect "#" {send "nmcli connection up $2\r"}	
	expect "#" {send "exit\r"}
EOF
expect << EOF
	expect "$" {send "ssh -X root@$3\r"}
	expect "(yes/no)?" {send "yes\r"}
	expect "#" {send "exit\r"}
EOF
ssh -X root@$3
