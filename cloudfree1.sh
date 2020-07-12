#!/bin/bash

printf "%s" "Waiting for Tasmota device ..."
while ! timeout 1 ping -c 1 -n 192.168.1.150 &> /dev/null
do
    printf "%c" "."
done
printf "\n%s\n"  "Tasmota device found"
sleep 2
printf "\n%s\n"  "Configuring device..."
curl -sS "http://192.168.1.150/co?t1=%7B%22NAME%22%3A%22CloudFree%22%2C%22GPIO%22%3A%5B255%2C255%2C56%2C255%2C255%2C255%2C0%2C0%2C255%2C17%2C255%2C21%2C255%5D%2C%22FLAG%22%3A0%2C%22BASE%22%3A18%7D&t2=on&wp=****&b1=on&dn=CloudFree&a0=CloudFree&save=" > /dev/null

printf "%s" "Rebooting ..."
sleep 2
while ! timeout 1 ping -c 1 -n 192.168.1.150 &> /dev/null
do
    printf "%c" "."
done
printf "\n%s\n"  "Back Online"

sleep 3

printf "\n%s\n" "Turning on and off 3 times"
for i in 1 2 3 4 5 6
do
   curl "http://192.168.1.150/cm?cmnd=Power%20TOGGLE"
   sleep 1
done

printf "\n%s\n"  "Turning off static IP and removing Wi-Fi credentials..."
curl -sS "http://192.168.1.150/cm?cmnd=IPAddress1%200.0.0.0&IPAddress2%200.0.0.0&IPAddress3%200.0.0.0&IPAddress4%200.0.0.0cmnd=Ssid1%201" > /dev/null
sleep 1
curl -sS "http://192.168.1.150/wi?s1=&p1=&s2=&p2=&h=%25s-%2504d&c=&save=" > /dev/null
printf "\n%s\n" "Testing is complete. The device is rebooting."

exit
