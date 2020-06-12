                  #############################################
############################### SERVICE SCANNING ###############################
                  #############################################

echo -e "\u001b[34;1m[!]\e[0m Starting service enumeration"; sleep 0.1

echo -e "\u001b[28;1m[-]\e[0m Running nbtenum against hosts with NetBIOS"; sleep 0.1
sudo nbtscan -f enumeration/port-enum/2.port-445t-smb.host -r > enumeration/service-enum/1.netbios.nbtscan

echo -e "\u001b[28;1m[-]\e[0m Further NetBIOS/SMB enumeration with enum4linux (threaded, will run 10m: $(date))"; sleep 0.1
while read l; do timeout 10m $(echo $l >> enumeration/service-enum/2.smb.enum4linux.$l; enum4linux -a $l >> enumeration/service-enum/2.smb.enum4linux.$l 2>/dev/null &) 2>/dev/null; done < enumeration/port-enum/2.port-445t-smb.host; sleep 10m 2>/dev/null
cat enumeration/service-enum/2.smb.enum4linux.* > enumeration/service-enum/2.smb.enum4linux.all
echo -e "\u001b[28;1m[-]\e[0m Combined output into single files per service"; sleep 0.1

echo -e "\u001b[28;1m[-]\e[0m Running rpcinfo.nse against all hosts with RPCBIND"; sleep 0.1
nmap -Pn --script=rpcinfo -iL enumeration/port-enum/2.port-111t-rpcbind.host -oA enumeration/service-enum/3.rpcinfo.nse

echo -e "\u001b[28;1m[-]\e[0m Identify devices hosting NFS and scan for shares"; sleep 0.1
grep nfs enumeration/service-enum/3.rpcinfo.nse.gnmap | cut -d' ' -f2 > enumeration/service-enum/3.rpcinfo.nfs.host
nmap -Pn --script nfs-* -iL enumeration/service-enum/3.rpcinfo.nfs.host -oA enumeration/service-enum/3.rpcinfo.nfs.nse

echo -e "\u001b[28;1m[-]\e[0m Attempt banner grabbing of FTP (cmd will run for 30s: $(date))"; sleep 0.1
while read l; do timeout 30 $(echo $l > enumeration/service-enum/4.ftp.banner.$l; echo '\n' | nc $l 21 >> enumeration/service-enum/4.ftp.banner.$l 2>/dev/null &) 2>/dev/null; done < enumeration/port-enum/2.port-21t-ftp.host; sleep 30s
echo -e "\u001b[28;1m[-]\e[0m Attempt banner grabbing of SMTP (cmd will run for 30s: $(date))"; sleep 0.1
while read l; do timeout 30 $(echo $l > enumeration/service-enum/4.smtp.banner.$l ;echo 'VRFY root' | nc $l 25 >> enumeration/service-enum/4.smtp.banner.$l 2>/dev/null &) 2>/dev/null; done < enumeration/port-enum/2.port-25t-smtp.host; sleep 30s
echo -e "\u001b[28;1m[-]\e[0m Attempt banner grabbing of HTTP (cmd will run for 10s: $(date))"; sleep 0.1
while read l; do timeout 10 $(echo $l > enumeration/service-enum/4.http.banner.$l ;echo '\n' | nc $l 80 >> enumeration/service-enum/4.http.banner.$l 2>/dev/null &) 2>/dev/null; done < enumeration/port-enum/2.port-80t-http.host; sleep 10s
cat enumeration/service-enum/4.ftp.banner.* > enumeration/service-enum/4.ftp.banner.all
cat enumeration/service-enum/4.smtp.banner.* > enumeration/service-enum/4.smtp.banner.all
cat enumeration/service-enum/4.http.banner.* > enumeration/service-enum/4.http.banner.all
echo -e "\u001b[28;1m[-]\e[0m Combined output into single files per service"; sleep 0.1

echo -e "\u001b[28;1m[-]\e[0m Enumerating SNMP with snmp-check (cmd will run for 5m: $(date))"; sleep 0.1
while read l; do timeout 5m $(echo $l > enumeration/service-enum/5.snmp.check.$l; snmp-check -c public $l >> enumeration/service-enum/5.snmp.check.$l 2>/dev/null &); 2>/dev/null & done < enumeration/port-enum/2.port-161u-snmp.host; sleep 5m

echo -e "\u001b[28;1m[-]\e[0m Enumerating HTTP with Nikto (cmd will run for 20m: $(date))"; sleep 0.1
while read l; do timeout 20m $(nikto -host $l >> service-enum/5.http.nikto.$l 2>/dev/null &); done < port-enum/2.port-80t-http.host; 2>/dev/null & sleep 20m

echo -e "\u001b[32;1m[+]\e[0m Service enumeration complete\n"; sleep 0.1
