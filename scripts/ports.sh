                  #############################################
############################### PORT SCANNING ###############################
                  #############################################

echo -e "\u001b[34;1m[!]\e[0m Port scanning target subnet (will update every five minutes)"; sleep 0.1
echo -e "\u001b[28;1m[-]\e[0m Started TCP connect scan on 1-49151 TCP ports (this will take roughly 5m/host)"; sleep 0.1
sudo nmap -Pn -sT -p 1-49151 --stats-every 5m -iL enumeration/discovery/8.alives.host -oA enumeration/port-enum/1.tALL.ports
echo -e "\u001b[28;1m[-]\e[0m Started UDP scan on top-1K UDP ports, aproximately 30 seconds(max) per host"; sleep 0.1
sudo nmap -Pn -sU --top-ports=1000 --stats-every 5m -iL enumeration/discovery/8.alives.host -oA enumeration/port-enum/1.uALL.ports
echo -e "\u001b[32;1m[+]\e[0m Port scanning complete\n"; sleep 0.1

echo -e "\u001b[34;1m[!]\e[0m Parsing data"; sleep 0.1
grep 21\/.*open.*\/tcp\/\/ftp enumeration/port-enum/1.t200.ports.gnmap | cut -d' ' -f2 > enumeration/port-enum/2.port-21t-ftp.host
echo -e "\u001b[28;1m[-]\e[0m Generated hosts manifest for TCP 21/FTP"; sleep 0.1
grep 22\/.*open.*\/tcp\/\/ssh enumeration/port-enum/1.t200.ports.gnmap | cut -d' ' -f2 > enumeration/port-enum/2.port-22t-ssh.host
echo -e "\u001b[28;1m[-]\e[0m Generated hosts manifest for TCP 22/SSH"; sleep 0.1
grep 23\/.*open.*\/tcp\/\/telnet enumeration/port-enum/1.t200.ports.gnmap | cut -d' ' -f2 > enumeration/port-enum/2.port-23t-telnet.host
echo -e "\u001b[28;1m[-]\e[0m Generated hosts manifest for TCP 23/TELNET"; sleep 0.1
grep 25\/.*open.*\/tcp\/\/smtp enumeration/port-enum/1.t200.ports.gnmap | cut -d' ' -f2 > enumeration/port-enum/2.port-25t-smtp.host
echo -e "\u001b[28;1m[-]\e[0m Generated hosts manifest for TCP 25/SMTP"; sleep 0.1
grep 80\/.*open.*\/tcp\/\/http enumeration/port-enum/1.t200.ports.gnmap | cut -d' ' -f2 > enumeration/port-enum/2.port-80t-http.host
echo -e "\u001b[28;1m[-]\e[0m Generated hosts manifest for TCP 80/HTTP"; sleep 0.1
grep 111\/.*open.*\/tcp\/\/rpcbind enumeration/port-enum/1.t200.ports.gnmap | cut -d' ' -f2 > enumeration/port-enum/2.port-111t-rpcbind.host
echo -e "\u001b[28;1m[-]\e[0m Generated hosts manifest for TCP 111/RPCBIND"; sleep 0.1
grep 139\/.*open.*\/tcp\/\/netbios-ssn enumeration/port-enum/1.t200.ports.gnmap | cut -d' ' -f2 > enumeration/port-enum/2.port-139t-netbios.host
echo -e "\u001b[28;1m[-]\e[0m Generated hosts manifest for TCP 139/NETBIOS"; sleep 0.1
grep 161\/.*open.*\/udp\/\/snmp enumeration/port-enum/1.t200.ports.gnmap | cut -d' ' -f2 > enumeration/port-enum/2.port-161u-snmp.host
echo -e "\u001b[28;1m[-]\e[0m Generated hosts manifest for UDP 161/SNMP"; sleep 0.1

echo -e "\u001b[28;1m[-]\e[0m Generated hosts manifest for UDP 389/LDAP"; sleep 0.1
grep 443\/.*open.*\/tcp\/\/https enumeration/port-enum/1.t200.ports.gnmap | cut -d' ' -f2 > enumeration/port-enum/2.port-443t-https.host
echo -e "\u001b[28;1m[-]\e[0m Generated hosts manifest for TCP 443/TLS-SSL"; sleep 0.1
grep 445\/.*open.*\/tcp\/\/microsoft-ds enumeration/port-enum/1.t200.ports.gnmap | cut -d' ' -f2 > enumeration/port-enum/2.port-445t-smb.host
echo -e "\u001b[28;1m[-]\e[0m Generated hosts manifest for TCP 445/SMB"; sleep 0.1
echo -e "\u001b[32;1m[+]\e[0m Payloads built\n"; sleep 0.1
