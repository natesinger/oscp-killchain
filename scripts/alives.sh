                  #############################################
############################### ALIVES enumeration/discovery ###############################
                  #############################################

echo -e "\u001b[34;1m[!]\e[0m Establishing information on alive hosts"; sleep 0.1

nmap -n -sL $1 | awk '/Nmap scan report/{print $NF}' > enumeration/discovery/1.targets.host
echo -e "\u001b[28;1m[-]\e[0m Built target manifest at enumeration/discovery/1.targets.host"; sleep 0.1

echo $2 | sed -E -e 's/ /\n/g' > enumeration/discovery/2.nostrike.host
echo -e "\u001b[28;1m[-]\e[0m Built no-strike manifest at enumeration/discovery/2.nostrike.host"; sleep 0.1

grep -v -x -f enumeration/discovery/2.nostrike.host enumeration/discovery/1.targets.host > enumeration/discovery/3.targets-nostrike.host
echo -e "\u001b[28;1m[-]\e[0m Created no-strike-removed targets manifest at enumeration/discovery/3.targets-nostrike.host"; sleep 0.1

echo -e "\u001b[28;1m[!]\e[0m Performing basic ICMP scan on target subnet"; sleep 0.1
nmap -sn -iL enumeration/discovery/3.targets-nostrike.host -oG enumeration/discovery/4.alives.nmap.icmp > /dev/null
cat enumeration/discovery/4.alives.nmap.icmp | grep 'Status: Up' | cut -d' ' -f 2 > enumeration/discovery/5.alives.nmap.icmp.host
echo -e "\u001b[28;1m[-]\e[0m Created ICMP alives manifest at enumeration/discovery/5.alives.nmap.icmp.host"; sleep 0.1

echo -e "\u001b[28;1m[!]\e[0m Scanning for alives based on top 10 TCP and top 10 UDP ports"; sleep 0.1
sudo nmap -sT -sU --top-ports=10 -iL enumeration/discovery/3.targets-nostrike.host -oG enumeration/discovery/6.alives.nmap.basicports > /dev/null
cat enumeration/discovery/6.alives.nmap.basicports | grep 'Status: Up' | cut -d' ' -f2 > enumeration/discovery/7.alives.nmap.basicports.host
echo -e "\u001b[28;1m[-]\e[0m Created ICMP alives manifest at enumeration/discovery/5.alives.nmap.icmp.host"; sleep 0.1

cat enumeration/discovery/5.alives.nmap.icmp.host enumeration/discovery/7.alives.nmap.basicports.host | sort -t . -k 1,1n -k 2,2n -k 3,3n -k 4,4n -u > enumeration/discovery/8.alives.host
echo -e "\u001b[28;1m[-]\e[0m Merged findings into one hosts manifest at enumeration/discovery/7.alives.nmap.basicports.host"; sleep 0.1

echo -e "\u001b[32;1m[+]\e[0m Database of alives established\n"; sleep 0.1
echo -e "\u001b[35;1m[i]\e[0m Discovered $(wc -l enumeration/discovery/8.alives.host | cut -d' ' -f1) alives within the range $target_cidr\n"; sleep 0.1
