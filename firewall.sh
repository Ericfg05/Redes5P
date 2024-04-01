iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

iptables -A INPUT -p tcp --dport 80:80 --sport 80:80 -j ACCEPT
iptables -A INPUT --dport 443:443 --sport 443:443 -j ACCEPT

iptables -I INPUT --m string --algo bm --string "games" -j DROP
iptables -I INPUT --m string --algo bm --string " www.jogosonline.com.br" ! -s 10.1.1.100 -j DROP

iptables -I INPUT -p ICMP -j LOG --limit 5/second

iptables -A INPUT -p udp --dport 53 -j ACCEPT
iptables -A INPUT -p tcp --dport 53 -j ACCEPT

iptables -A INPUT -p tcp --dport 80 -d 192.168.1.100 -j ACCEPT

iptables -A PREROUTING -t nat -i eth0 -p tcp 200.20.5.1:80 -j DNAT --to 192.168.1.100:80

iptables -A FORWARD -p tcp -d 192.168.1.100 --dport 80 -j ACCEPT