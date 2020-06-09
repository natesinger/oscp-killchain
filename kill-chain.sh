cwd=$(pwd)
f_plog=$cwd'/log.pcap'
d_http=$cwd/

#red     echo -e "\u001b[31;1m[!]\e[0m test"
#green     echo -e "\u001b[32;1m[!]\e[0m test"
#blue      echo -e "\u001b[34;1m[!]\e[0m test"
#yellow     echo -e "\u001b[33;1m[!]\e[0m test"
#white     echo -e "\u001b[28;1m[!]\e[0m test"

############################# INITIAL BANNER/NOTES #############################
echo -e "\e[1m\e[93mLets get this fuckin' show on the road, before we start, remember:\e[0m
      - It's better to take 30 seconds longer and not miss something obvious
          **Espically for the BOF**
      - Good chance theres a simple RCE for something on the box, \e[101mDON'T RABBIT-HOLE\e[0m
      - We've got 24 hours, if we don't have anything after 8, we've still got 2/3s

\e[1m\e[93mGameplan:\e[0m
      1. Start this script
      2. Finish BOF (screenshot... screenshot... screenshot...)
      3. Update notes based on scripts results (take time here, do this right)
      4. Determine our path forward
          a. look for easy RCE based on versions (for example)
          b. organize what looks promising into a task list
          c. do every item on the task list or at least foothold each machine
      5. Enumerate for privesce
      6. Determine our path forward based on privesce
      7. Ensure approperiate note taking has occured, and all info is avail for reporting\n"

                  #############################################
############################### PRE-SCRIPT CHECKS ##############################
                  #############################################

echo -e "\e[1m\e[93mPre-script Monitor Checks:\e[0m"
read -n 1 -s -r -p "      1. [Pane 0] Is the VPN connected?: [Press any key to Continue]"; echo ""
read -n 1 -s -r -p "      2. [Pane 1] Ping external connection?: [Press any key to Continue]"; echo ""
read -n 1 -s -r -p "      3. [Pane 2] Ping known lab connection?: [Press any key to Continue]"; echo -e ""
read -n 1 -s -r -p "      4. [Pane 3] Logging binary pcap stream: [Press any key to Continue]"; echo -e ""
read -n 1 -s -r -p "      5. [Pane 4] Viewing pcap stream as it occurs: [Press any key to Continue]"; echo -e ""
read -n 1 -s -r -p "      6. [Pane 5] Showing system resources with top: [Press any key to Continue]"; echo -e ""
read -n 1 -s -r -p "      7. [Pane 6] HTTP resource server started: [Press any key to Continue]"; echo -e "\n"
read -p "Target domain root, like 'google.com': " target_domain
read -p "Target subnet (CIDR), like '172.16.19.0/16': " target_cidr
read -p "No-strike, space delimited like '172.16.19.12 172.1...': " target_nostrike; echo ""
read -n 1 -s -r -p "Are these values correct? [Press any key to continue]: "; echo -e "\n"

                  #############################################
################################### GAMETIME ###################################
                  #############################################

echo -e "\e[1m\e[93mGametime:\e[0m"
read -n 1 -s -r -p "[Press any key to Start]"; echo -e "\e[1A\e[K                        "

########################## BUILD DIRECTORY STRUCTURE ###########################
echo -e "\u001b[34;1m[!]\e[0m Building working directories"; sleep 0.1
mkdir -p discovery; sleep 0.1
echo -e "\u001b[28;1m[-]\e[0m Making local directory: discovery/"; sleep 0.1
mkdir -p port-enum; sleep 0.1
echo -e "\u001b[28;1m[-]\e[0m Making local directory: port-enum/"; sleep 0.1
mkdir -p os-enum; sleep 0.1
echo -e "\u001b[28;1m[-]\e[0m Making local directory: os-enum/"; sleep 0.1
mkdir -p vuln; sleep 0.1
echo -e "\u001b[28;1m[-]\e[0m Making local directory: vuln/"; sleep 0.1
mkdir -p service-enum; sleep 0.1
echo -e "\u001b[28;1m[-]\e[0m Making local directory: service-enum/"; sleep 0.1
mkdir -p .resource; sleep 0.1
echo -e "\u001b[28;1m[-]\e[0m Making local directory: .resource/"; sleep 0.1
echo -e "\u001b[32;1m[+]\e[0m Built local directories\n"; sleep 0.1

########################### DOWNLOAD/UNZIP RESOURCES ###########################
echo -e "\u001b[34;1m[!]\e[0m Gathering resources"; sleep 0.1
echo -e "\u001b[28;1m[-]\e[0m Downloading top 1k USA names - male"; sleep 0.1
wget -q https://raw.githubusercontent.com/danielmiessler/SecLists/master/Usernames/Names/malenames-usa-top1000.txt -O .resource/1.male-name.1k.ulist
echo -e "\u001b[28;1m[-]\e[0m Downloading top 1k USA names - female"; sleep 0.1
wget -q https://raw.githubusercontent.com/danielmiessler/SecLists/master/Usernames/Names/femalenames-usa-top1000.txt -O .resource/1.female-name.1k.ulist
echo -e "\u001b[28;1m[-]\e[0m Downloading top 1k USA names - surname"; sleep 0.1
wget -q https://raw.githubusercontent.com/danielmiessler/SecLists/master/Usernames/Names/familynames-usa-top1000.txt -O .resource/1.surname.1k.ulist
echo -e "\u001b[28;1m[-]\e[0m Unzipping rockyou wordlist to local dir"; sleep 0.1
gunzip -c /usr/share/wordlists/rockyou.txt.gz > .resource/2.rockyou.plist
echo -e "\u001b[32;1m[+]\e[0m Unzipped and downloaded resources\n"; sleep 0.1

############################ BASIC PAYLOAD CREATION ############################
echo -e "\u001b[34;1m[!]\e[0m Building payloads"; sleep 0.1
echo -e "\u001b[28;1m[-]\e[0m <PLACEHOLDER> building x shell for y"; sleep 0.1
echo -e "\u001b[32;1m[+]\e[0m Payloads built\n"; sleep 0.1

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

                  #############################################
############################### PORT SCANNING ###############################
                  #############################################

echo -e "\u001b[34;1m[!]\e[0m Port scanning"; sleep 0.1
echo -e "\u001b[28;1m[-]\e[0m <PLACEHOLDER>"; sleep 0.1
echo -e "\u001b[32;1m[+]\e[0m ports scanned\n"; sleep 0.1

############################# INITIAL PORT SCANNING ############################
#Full port scan on previously identified alives
#Create service set files for further port enumeration/OS discovery

############################ INITIAL OS ENUMERATION ############################
#Basic OS scan with nmap
#SMB OS discovery with NSE

######################### INITIAL SERVICE ENUMERATION ##########################
#Enumeration of NetBIOS with nbtenum
#Enumeration of SMB/NetBIOS with enum4linux
#Enumeration of RPC
#Identify devices hosting NFS and scan for shares
#Scan for shares with smbclient
#Attempt banner grabbing on various protocols
#Enumerate SNMP with snmp-check
#Enumerate HTTP servers with Nikto
#<LDAP PLACEHOLDER>

######################## AUTOMATED SIGNATURE MATCHING ##########################
#SMB
#FTP
#SMTP

                  #############################################
########################## SUPPLEMENTARY SERVICE RECON #########################
                  #############################################
#THIS SHOULD BE A FOREVER UNTIL EXIT LOOP

#do automated stuff here based on supplementary service recon block on flowchart



                  #############################################
################################# NOTES UPDATES ################################
                  #############################################
#Notes about alives, maybe automate this somehow to make it easier



################################################################################
############################### ACTIVE ENUMERATION #############################
################################################################################
