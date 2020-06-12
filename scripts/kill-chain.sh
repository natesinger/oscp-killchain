cwd=$(pwd)
f_plog=$cwd'/log.pcap'
d_http=$cwd/

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

sleep 1; echo -e "\e[1m\e[93mPre-script Monitor Checks:\e[0m" #this sleep is a bug preventer
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
mkdir -p enumeration/discovery; sleep 0.1
echo -e "\u001b[28;1m[-]\e[0m Making local directory: enumeration/discovery/"; sleep 0.1
mkdir -p enumeration/port-enum; sleep 0.1
echo -e "\u001b[28;1m[-]\e[0m Making local directory: enumeration/port-enum/"; sleep 0.1
mkdir -p enumeration/os-enum; sleep 0.1
echo -e "\u001b[28;1m[-]\e[0m Making local directory: enumeration/os-enum/"; sleep 0.1
mkdir -p enumeration/vuln; sleep 0.1
echo -e "\u001b[28;1m[-]\e[0m Making local directory: enumeration/vuln/"; sleep 0.1
mkdir -p enumeration/service-enum; sleep 0.1
echo -e "\u001b[28;1m[-]\e[0m Making local directory: enumeration/service-enum/"; sleep 0.1
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

bash scripts/alives.sh $target_cidr $target_nostrike
bash scripts/ports.sh
bash scripts/os.sh
bash scripts/services.sh
bash scripts/vuln.sh

echo "update the following in cherry tree:
- Alives based on enumeration/discovery/8.alives.host
- TCP ports for each alive based on enumeration/port-enum/1.tALL.ports
- UDP ports based on enumeration/port-enum/1.uALL.ports
- OS fingerprint based on enumeration/os-enum/1.basic-nmap.os
- OS fingerprint based on NSE SMB script, enumeration/os-enum/2.smb-enum.nmap
"

#red     echo -e "\u001b[31;1m[!]\e[0m test"
#green     echo -e "\u001b[32;1m[!]\e[0m test"
#blue      echo -e "\u001b[34;1m[!]\e[0m test"
#yellow     echo -e "\u001b[33;1m[!]\e[0m test"
#white     echo -e "\u001b[28;1m[!]\e[0m test"
