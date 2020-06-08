cwd=$(pwd)
f_log=$cwd'/.logfile';touch $f_log
d_http=$cwd/

####################### START LOGGER FOR MAIN WORKSPACE ########################
l_start=0
l_end=$(wc -l $f_log)

tmux capture-pane -t "main:0" -S $l_start -E $l_end >> $f_log

############################# INITIAL BANNER/NOTES #############################
echo -e "
\e[1m\e[93mLets get this fuckin' show on the road, before we start, remember:\e[0m
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
      7. Ensure approperiate note taking has occured, and all info is avail for reporting

\e[1m\e[93mWorkspace Details:\e[0m
"

########################### ENSURE VPN ESTABLISHMENT ###########################
#ENSURE A VPN CONNECTION IS ESTABLISHED

########################## ENSURE INTERNET CONNECTION ##########################
#ENSURE A VPN CONNECTION IS ESTABLISHED

########################## BUILD DIRECTORY STRUCTURE ###########################
#<placeholder>



########################### DOWNLOAD/UNZIP RESOURCES ###########################
#Download name files
#Unzip and grab the rockyou dictionary

############################ BASIC PAYLOAD CREATION ############################
#Create payloads on whatever port as a easy access for rshell

############################ BASIC PAYLOAD CREATION ############################
#start http server to host resources, do this in another tmux window



                  #############################################
############################# ACTIVE RECONNAISSANCE ############################
                  #############################################

############################ BUILD AND REFINE SCOPE ############################
#From the target scope, build a list of all addresses in a CIDR block
#Manually build a no-strike list (at a min, the dedicated boxes, ie: windows)
#Remove no-strike addresses from the targets file:

################################ DISCOVER ALIVES ###############################
#Run an initial host discovery scan, with -sn to prevent further port scanning
#Refine to only addresses
#Run a top-10 port query against scope, in case ICMP missed anything
#Refine to only addresses
#Aggregate these scans to create a master alives file
#Basic DNS reverse pointer lookup

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
