#!/bin/bash

clear
RED='\e[1;91m'
BLUE='\033[0;34m'
BRED='\033[1;31m' 
PURPLE='\033[0;35m'
WHITE='\033[0;37m'
BCYAN='\033[1;36m'
YELLOW='\033[0;33m'
BWHITE='\033[1;37m'
RESET='\033[0m'
VER='0.1'
user=$(whoami)
date=$(date "+%D Time: %I:%M %p")

# Banner
banner(){
cat<<"EOF"
         _nnnn_                      
        dGGGGMMb     ,"""""""""""""""""""""""""""""""""""""".
       @p~qp~~qMb    |             XSS SCANNER              |
       M|@||@) M|   _;......................................'
       @,----.JM| -'
      JS^\__/  qKL
     dZP        qKRb
    dZP          qKKb
   fZP            SMMb
   HZM            MMMM
   FqM            MMMM
 __| ".        |\dS"qML
 |    `.       | `' \Zq
_)      \.___.,|     .'
\____   )MMMMMM|   .'
     `-'       `--' dogukaN
EOF
echo ""
echo -e "${YELLOW}+ -- --=[Date: $date"
echo -e "${RED}+ -- --=[Welcome $user :)"
echo -e "${BLUE}+ -- --=[XSS Scanner v$VER by @dogukankurnaz"
echo -e "${PURPLE}+ -- --=[https://github.com/dogukankurnaz"
echo -e "${RESET}"
}
banner
echo -e "${BWHITE} $1 Starting a vulnerability scan."
echo -e "${BWHITE} Payload File = $2"
sleep 4


#URL CHECK
if [[ $1 == '' || $2 == '' ]]
then
	echo "FATAL ERROR!"
	echo "Example command: $0 http://xxxxx.com/?query=1 payload.txt"
	exit 1
fi


url="${1}"
list="${2}"
for exploit in $(cat "${list}")
	do
        curl  -s -X GET  "${url}""${exploit}" > site.txt | echo -e "Successful Payload   : ${url}${exploit}" >> exploit.txt | cat site.txt | awk -vRS="</html>" '/<html>/{gsub(/.*<html>|\n+/,"");print;exit}' >> html_parsel.txt | cat html_parsel.txt | cut -d ' ' -f1,2,3,4 >> result.txt | sort result.txt | uniq -d > last_result.txt
		echo -e "${BRED} [*] Successful Payload   : ${RESET} ${url}${exploit}"
	done
    if [ -s last_result.txt ] ; 
    then
        echo -e "${BCYAN} [!] XSS Vulnerability Found!"
        echo -e "${BCYAN} Check $(pwd)/exploit.txt " 
    else
        echo -e " ${WHITE}[!] XSS Vulnerability Not Found!"
    fi

rm html_parsel.txt last_result.txt result.txt site.txt



