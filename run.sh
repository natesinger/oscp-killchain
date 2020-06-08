#!/usr/bin/bash
############################ ENSURE SUPERUSER PRIVS ############################
if [ "$EUID" -ne 0 ]; then echo -e "\e[1m\e[93m[!]\e[0m Please run as root"; exit; fi

############################# DEPENDENCY CREATION ##############################
cwd=$(pwd)
f_log="$cwd/.logfile"; touch $f_log
d_http="$cwd/http_serve"; mkdir $d_http

                  #############################################
############################### ENVIRONMENT SETUP ##############################
                  #############################################

######################### BUILD TMUX MONITOR DASHBOARD #########################
gnome-terminal --title 'MONITOR' --maximize --geometry 1x1+3840+0 -- tmux new -s 'monitor'
tmux splitw -h; tmux resize-pane -R 17; tmux splitw -v; tmux splitw -v -t 0
tmux splitw -v -t 0; tmux splitw -h -t 1; tmux resize-pane -L 5
tmux send-keys -t "monitor:0.0" C-z "<start VPN tunnel>"
tmux send-keys -t "monitor:0.1" C-z "ping 8.8.8.8" Enter
tmux send-keys -t "monitor:0.2" C-z "<ping off lab host>"
tmux send-keys -t "monitor:0.3" C-z "tail -f $f_log" Enter
tmux send-keys -t "monitor:0.4" C-z "top" Enter
tmux send-keys -t "monitor:0.5" C-z "cd $d_http" Enter "sudo python -m SimpleHttpServer 80" Enter

########################## BUILD TMUX MAIN WORKSPACE ###########################
gnome-terminal --title 'WORKSPACE' --maximize --geometry 1x1+0+0 -- tmux new -s 'main'

############################## ITS TIME TO PARTY ###############################
tmux send-keys -t "main:0" C-z "run.sh" Enter
