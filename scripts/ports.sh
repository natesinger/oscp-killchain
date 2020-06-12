                  #############################################
############################### PORT SCANNING ###############################
                  #############################################

echo -e "\u001b[34;1m[!]\e[0m Port scanning target subnet (will auto-update every five minutes)"; sleep 0.1
echo -e "\u001b[28;1m[-]\e[0m Started TCP connect scan on 1-49151 TCP ports, aproximately 30 seconds per host"; sleep 0.1
sudo nmap -Pn -n -sS 1-49151 -sV --stats-every 5m -iL enumeration/discovery/8.alives.host -oA enumeration/port-enum/1.tALL.ports
echo -e "\u001b[28;1m[-]\e[0m Started UDP scan on top-1K UDP ports, aproximately 50 seconds per host"; sleep 0.1
sudo nmap -Pn -sU --top-ports=1000 --stats-every 5m -iL enumeration/discovery/8.alives.host -oA enumeration/port-enum/1.uALL.ports
echo -e "\u001b[32;1m[+]\e[0m Port scanning complete\n"; sleep 0.1


echo -e "\u001b[34;1m[!]\e[0m Parsing data"; sleep 0.1

grep 21\/.*open.*\/tcp\/\/ftp enumeration/port-enum/1.tALL.ports.gnmap | cut -d' ' -f2 > enumeration/port-enum/2.port-21t-ftp.host
echo -e "\u001b[28;1m[-]\e[0m Generated hosts manifest for TCP 21/FTP"
echo -e "\u001b[35;1m[i]\e[0m Identified $(wc -l enumeration/port-enum/2.port-21t-ftp.host | cut -d' ' -f1) hosts"; sleep 0.1

grep 22\/.*open.*\/tcp\/\/ssh enumeration/port-enum/1.tALL.ports.gnmap | cut -d' ' -f2 > enumeration/port-enum/2.port-22t-ssh.host
echo -e "\u001b[28;1m[-]\e[0m Generated hosts manifest for TCP 22/SSH"
echo -e "\u001b[35;1m[i]\e[0m Identified $(wc -l enumeration/port-enum/2.port-22t-ssh.host | cut -d' ' -f1) hosts"; sleep 0.1

grep 23\/.*open.*\/tcp\/\/telnet enumeration/port-enum/1.tALL.ports.gnmap | cut -d' ' -f2 > enumeration/port-enum/2.port-23t-telnet.host
echo -e "\u001b[28;1m[-]\e[0m Generated hosts manifest for TCP 23/TELNET"p 0.1
echo -e "\u001b[35;1m[i]\e[0m Identified $(wc -l enumeration/port-enum/2.port-23t-telnet.host | cut -d' ' -f1) hosts"; sleep 0.1

grep 25\/.*open.*\/tcp\/\/smtp enumeration/port-enum/1.tALL.ports.gnmap | cut -d' ' -f2 > enumeration/port-enum/2.port-25t-smtp.host
echo -e "\u001b[28;1m[-]\e[0m Generated hosts manifest for TCP 25/SMTP"
echo -e "\u001b[35;1m[i]\e[0m Identified $(wc -l enumeration/port-enum/2.port-25t-smtp.host | cut -d' ' -f1) hosts"; sleep 0.1

grep 80\/.*open.*\/tcp\/\/http enumeration/port-enum/1.tALL.ports.gnmap | cut -d' ' -f2 > enumeration/port-enum/2.port-80t-http.host
echo -e "\u001b[28;1m[-]\e[0m Generated hosts manifest for TCP 80/HTTP"
echo -e "\u001b[35;1m[i]\e[0m Identified $(wc -l enumeration/port-enum/2.port-80t-http.host | cut -d' ' -f1) hosts"; sleep 0.1

grep 111\/.*open.*\/tcp\/\/rpcbind enumeration/port-enum/1.tALL.ports.gnmap | cut -d' ' -f2 > enumeration/port-enum/2.port-111t-rpcbind.host
echo -e "\u001b[28;1m[-]\e[0m Generated hosts manifest for TCP 111/RPCBIND"
echo -e "\u001b[35;1m[i]\e[0m Identified $(wc -l enumeration/port-enum/2.port-111t-rpcbind.host | cut -d' ' -f1) hosts"; sleep 0.1

grep 139\/.*open.*\/tcp\/\/netbios-ssn enumeration/port-enum/1.tALL.ports.gnmap | cut -d' ' -f2 > enumeration/port-enum/2.port-139t-netbios.host
echo -e "\u001b[28;1m[-]\e[0m Generated hosts manifest for TCP 139/NETBIOS"
echo -e "\u001b[35;1m[i]\e[0m Identified $(wc -l enumeration/port-enum/2.port-139t-netbios.host | cut -d' ' -f1) hosts"; sleep 0.1

grep 161\/.*open.*\/udp\/\/snmp enumeration/port-enum/1.uALL.ports.gnmap | cut -d' ' -f2 > enumeration/port-enum/2.port-161u-snmp.host
echo -e "\u001b[28;1m[-]\e[0m Generated hosts manifest for UDP 161/SNMP"
echo -e "\u001b[35;1m[i]\e[0m Identified $(wc -l enumeration/port-enum/2.port-161u-snmp.host | cut -d' ' -f1) hosts"; sleep 0.1

grep 389\/.*open.*\/tcp\/\/ldap enumeration/port-enum/1.tALL.ports.gnmap | cut -d' ' -f2 > enumeration/port-enum/2.port-389t-ldap.host
echo -e "\u001b[28;1m[-]\e[0m Generated hosts manifest for UDP 389/LDAP"
echo -e "\u001b[35;1m[i]\e[0m Identified $(wc -l enumeration/port-enum/2.port-389t-ldap.host | cut -d' ' -f1) hosts"; sleep 0.1

grep 443\/.*open.*\/tcp\/\/https enumeration/port-enum/1.tALL.ports.gnmap | cut -d' ' -f2 > enumeration/port-enum/2.port-443t-https.host
echo -e "\u001b[28;1m[-]\e[0m Generated hosts manifest for TCP 443/TLS-SSL"
echo -e "\u001b[35;1m[i]\e[0m Identified $(wc -l enumeration/port-enum/2.port-443t-https.host | cut -d' ' -f1) hosts"; sleep 0.1

grep 445\/.*open.*\/tcp\/\/microsoft-ds enumeration/port-enum/1.tALL.ports.gnmap | cut -d' ' -f2 > enumeration/port-enum/2.port-445t-smb.host
echo -e "\u001b[28;1m[-]\e[0m Generated hosts manifest for TCP 445/SMB"
echo -e "\u001b[35;1m[i]\e[0m Identified $(wc -l enumeration/port-enum/2.port-445t-smb.host | cut -d' ' -f1) hosts"; sleep 0.1

echo -e "\u001b[32;1m[+]\e[0m Individual service-host manifests built\n"; sleep 0.1
