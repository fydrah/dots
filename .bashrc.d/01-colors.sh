c_black=`tput setaf 0`
c_red=`tput setaf 1`
c_red_purple=`tput setaf 197`
c_green=`tput setaf 2`
c_green_blue=`tput setaf 35`
c_yellow=`tput setaf 3`
c_blue=`tput setaf 4`
c_magenta=`tput setaf 5`
c_cyan=`tput setaf 6`
c_white=`tput setaf 7`
c_reset=`tput sgr0`

alias colorlist='echo "tput setaf XXX" && for i in $(seq 255); do echo -n "$(tput setaf $i) $i "; done'
