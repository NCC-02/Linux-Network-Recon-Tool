#!/bin/bash
#Nicolas Coles
chmod 777 ./NetworkReconColes.sh
#Linux network recconnaisance tool 

mainmenu(){

echo -e "\n"
echo "************ MAIN MENU ************"
select var in "Ping Sweep" "Port Scan" "Print Scan Results" "Exit"
do
    case $var in 
        "Ping Sweep")
            pingsweep
            ;;
        "Port Scan")
            portscan
            ;;
        "Print Scan Results")
            scanresults
            ;;
        "Exit")
        echo "Exiting Program"
        exit
        ;;
    esac
done

}
pingsweep(){
echo -e "\n"
echo "************ Ping Sweep Results ************" >> pingsweep.txt
echo "*****************************************************************" >> pingresults.txt
date >> pingresults.txt
echo "*****************************************************************" >> pingresults.txt

echo -e "\n"

echo "Enter the first three sets of numbers in your IP Subnet, such that the first entry would be, for example, 192, second entry would be 168 and so on."
read a
read b
read c

for i in {1..100} #225 for all
do
    echo "Pinging address: $a.$b.$c.$i"
    ping -c 1 $a.$b.$c.$i > /dev/null
    [ $? -eq 0 ] && echo "IP: $a.$b.$c.$i is up" >> pingresults.txt

done

clear
echo "Results added to pingsweep.txt"
mainmenu

}
portscan(){

echo "*********  Port Scan Results *********" >> portscanresults.txt
echo "*****************************************************************" >> portscanresults.txt
date >> portscanresults.txt
echo "*****************************************************************" >> portscanresults.txt
echo "Enter the host name in a set of 4 numbers, such that the first number could be 192, second would be 168, and so on."
read a
read b
read c
read d
hostname=$a.$b.$c.$d
echo "Host name is: $hostname" >> portscanresults.txt
for port in {1..80}
do
    echo "Testing port $port"
    2>/dev/null echo > /dev/tcp/$hostname/$port
    if [ $? == 0 ]
    then
    {
        echo "$port is open" >> portscanresults.txt
        echo -e "\n" >> portscanresults.txt
    }
    fi
done
clear
echo "Results added to portscan.txt"
mainmenu

}
scanresults(){
echo "************ Print Scan Results *************"
select scan in "Ping Sweep Results" "Port Scan Results" "Return To Main Menu"
do
    case $scan in
    "Ping Sweep Results")
        cat pingresults.txt
        ;;
    "Port Scan Results")
        cat portscanresults.txt
        ;;
    "Return To Main Menu")
        mainmenu
        ;;
    esac
done 
}

mainmenu
