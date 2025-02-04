#!/bin/bash
# By workzap
# Pequeno script para permissao de autenticacao root
clear
[[ "$(whoami)" != "root" ]] && {
	clear
	echo -e "\033[1;31mEXECULTE COMO USUARIO ROOT, \033[1;32m(\033[1;33msudo -i\033[1;32m)\033[0m"
	exit
}

iptables -F
echo 'nameserver 1.1.1.1' > /etc/resolv.conf
echo 'nameserver 8.8.8.8' >> /etc/resolv.conf
apt update -y

[[ $(grep -c "prohibit-password" /etc/ssh/sshd_config) != '0' ]] && {
	sed -i "s/prohibit-password/yes/g" /etc/ssh/sshd_config
} > /dev/null
[[ $(grep -c "without-password" /etc/ssh/sshd_config) != '0' ]] && {
	sed -i "s/without-password/yes/g" /etc/ssh/sshd_config
} > /dev/null
[[ $(grep -c "#PermitRootLogin" /etc/ssh/sshd_config) != '0' ]] && {
	sed -i "s/#PermitRootLogin/PermitRootLogin/g" /etc/ssh/sshd_config
} > /dev/null
[[ $(grep -c "PasswordAuthentication" /etc/ssh/sshd_config) = '0' ]] && {
	echo 'PasswordAuthentication yes' > /etc/ssh/sshd_config
} > /dev/null
[[ $(grep -c "PasswordAuthentication no" /etc/ssh/sshd_config) != '0' ]] && {
	sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
} > /dev/null
[[ $(grep -c "#PasswordAuthentication no" /etc/ssh/sshd_config) != '0' ]] && {
	sed -i "s/#PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
} > /dev/null


sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config.d/60-cloudimg-settings.conf  > /dev/null


#sed -i "s/ChallengeResponseAuthentication no/#ChallengeResponseAuthentication no/g" /etc/ssh/sshd_config

service ssh restart > /dev/null

iptables -F
iptables -A INPUT -p tcp --dport 81 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp --dport 8799 -j ACCEPT
iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
iptables -A INPUT -p tcp --dport 1194 -j ACCEPT
iptables -A INPUT -p tcp --dport 7800 -j ACCEPT
iptables -A INPUT -p tcp --dport 5432 -j ACCEPT
iptables -A INPUT -p tcp --dport 6379 -j ACCEPT
clear && echo -ne "\033[1;32mDEFINA A SENHA ROOT\033[1;37m: "; read senha
[[ -z "$senha" ]] && {
echo -e "\n\033[1;31mSENHA INVALIDA !\033[0m"
exit 0
}
echo "root:$senha" | chpasswd
echo -e "\n\033[1;31m[ \033[1;33mOK ! \033[1;31m]\033[1;37m - \033[1;32mSENHA DEFINIDA ! \033[0m"
