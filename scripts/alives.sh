                  #############################################
############################### ALIVES DISCOVERY ###############################
                  #############################################

echo -e "\u001b[34;1m[!]\e[0m Establishing information on alive hosts"; sleep 0.1

nmap -n -sL $target_cidr | awk '/Nmap scan report/{print $NF}' > discovery/1.targets.host
echo -e "\u001b[28;1m[-]\e[0m Built target manifest at discovery/1.targets.host"; sleep 0.1

echo $target_nostrike | sed -E -e 's/ /\n/g' > discovery/2.nostrike.host
echo -e "\u001b[28;1m[-]\e[0m Built no-strike manifest at discovery/2.nostrike.host"; sleep 0.1

grep -v -x -f discovery/2.nostrike.host discovery/1.targets.host > discovery/3.targets-nostrike.host
echo -e "\u001b[28;1m[-]\e[0m Created no-strike-removed targets manifest at discovery/3.targets-nostrike.host"; sleep 0.1

echo -e "\u001b[28;1m[!]\e[0m Performing basic ICMP scan on target subnet"; sleep 0.1
nmap -sn -iL discovery/3.targets-nostrike.host -oG discovery/4.alives.nmap.icmp > /dev/null
cat discovery/4.alives.nmap.icmp | grep 'Status: Up' | cut -d' ' -f 2 > discovery/5.alives.nmap.icmp.host
echo -e "\u001b[28;1m[-]\e[0m Created ICMP alives manifest at discovery/5.alives.nmap.icmp.host"; sleep 0.1

echo -e "\u001b[28;1m[!]\e[0m Scanning for alives based on top 10 TCP and top 10 UDP ports"; sleep 0.1
sudo nmap -sT -sU --top-ports=10 -iL discovery/3.targets-nostrike.host -oG discovery/6.alives.nmap.basicports > /dev/null
cat discovery/6.alives.nmap.basicports | grep 'Status: Up' | cut -d' ' -f2 > discovery/7.alives.nmap.basicports.host
echo -e "\u001b[28;1m[-]\e[0m Created ICMP alives manifest at discovery/5.alives.nmap.icmp.host"; sleep 0.1

cat discovery/5.alives.nmap.icmp.host discovery/7.alives.nmap.basicports.host | sort -t . -k 1,1n -k 2,2n -k 3,3n -k 4,4n -u > discovery/8.alives.host
echo -e "\u001b[28;1m[-]\e[0m Merged findings into one hosts manifest at discovery/7.alives.nmap.basicports.host"; sleep 0.1

echo -e "\u001b[32;1m[+]\e[0m Database of alives established\n"; sleep 0.1
echo -e "\u001b[35;1m[i]\e[0m Discovered $(wc -l discovery/8.alives.host | cut -d' ' -f1) alives within the range $target_cidr\n"; sleep 0.1
