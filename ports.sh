                  #############################################
############################### PORT SCANNING ###############################
                  #############################################

echo -e "\u001b[34;1m[!]\e[0m Port scanning"; sleep 0.1
echo -e "\u001b[28;1m[-]\e[0m <PLACEHOLDER>"; sleep 0.1
echo -e "\u001b[32;1m[+]\e[0m ports scanned\n"; sleep 0.1

############################# INITIAL PORT SCANNING ############################
echo -e "\u001b[34;1m[!]\e[0m Building payloads"; sleep 0.1
echo -e "\u001b[28;1m[-]\e[0m <PLACEHOLDER> building x shell for y"; sleep 0.1
echo -e "\u001b[32;1m[+]\e[0m Payloads built\n"; sleep 0.1

change updates to every 5 mins (and note this)
sudo nmap -Pn -sT -sU -p- --stats-every 1m -iL discovery/8.alives.host -oA port-enum/1.t200.ports

grep 21\/.*open.*\/tcp\/\/ftp port-enum/1.t200.ports.gnmap | cut -d' ' -f2 > port-enum/2.port-21t-ftp.host
grep 22\/.*open.*\/tcp\/\/ssh port-enum/1.t200.ports.gnmap | cut -d' ' -f2 > port-enum/2.port-22t-ssh.host
grep 23\/.*open.*\/tcp\/\/telnet port-enum/1.t200.ports.gnmap | cut -d' ' -f2 > port-enum/2.port-23t-telnet.host
grep 25\/.*open.*\/tcp\/\/smtp port-enum/1.t200.ports.gnmap | cut -d' ' -f2 > port-enum/2.port-25t-smtp.host
grep 80\/.*open.*\/tcp\/\/http port-enum/1.t200.ports.gnmap | cut -d' ' -f2 > port-enum/2.port-80t-http.host
grep 111\/.*open.*\/tcp\/\/rpcbind port-enum/1.t200.ports.gnmap | cut -d' ' -f2 > port-enum/2.port-111t-rpcbind.host
grep 161\/.*open.*\/udp\/\/snmp port-enum/1.t200.ports.gnmap | cut -d' ' -f2 > port-enum/2.port-161u-snmp.host
grep 139\/.*open.*\/tcp\/\/netbios-ssn port-enum/1.t200.ports.gnmap | cut -d' ' -f2 > port-enum/2.port-139t-netbios.host
grep 443\/.*open.*\/tcp\/\/https port-enum/1.t200.ports.gnmap | cut -d' ' -f2 > port-enum/2.port-443t-https.host
grep 445\/.*open.*\/tcp\/\/microsoft-ds port-enum/1.t200.ports.gnmap | cut -d' ' -f2 > port-enum/2.port-445t-smb.host
