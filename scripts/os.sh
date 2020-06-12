                  #############################################
############################### OS SCAN ###############################
                  #############################################

echo -e "\u001b[34;1m[!]\e[0m Starting OS enumeration"; sleep 0.1

echo -e "\u001b[28;1m[-]\e[0m Performing basic nmap -O scan on all alives (1m updates)"; sleep 0.1
sudo nmap -Pn -O --stats-every 1m -iL enumeration/discovery/8.alives.host -oA enumeration/os-enum/1.basic-nmap.os

echo -e "\u001b[28;1m[-]\e[0m Using smb-os-discovery.nse to fingerprint SMB on relevant hosts (1m updates)"; sleep 0.1
nmap -Pn --stats-every 1m --script=/usr/share/nmap/scripts/smb-os-discovery.nse -iL enumeration/port-enum/2.port-445t-smb.host > enumeration/os-enum/2.smb-enum.nmap

echo -e "\u001b[32;1m[+]\e[0m OS enumeration complete\n"; sleep 0.1
