#!/bin/bash

printf "%s" "Waiting for Tasmota device ..."
while ! timeout 1 ping -c 1 -n 192.168.0.198 &> /dev/null
do
    printf "%c" "."
done
printf "\n%s\n"  "Tasmota device found"

sleep 2

printf "\n%s\n" "Turning on and off 3 times"
for i in 1 2 3
do
   curl "http://192.168.0.198/cm?cmnd=Power%20On"
   sleep 1
   curl "http://192.168.0.198/cm?cmnd=Power%20Off"
   sleep 1
done

printf "\n%s\n"  "Turning off static IP and removing Wi-Fi credentials..."
curl -sS "http://192.168.0.198/cm?cmnd=Reset%201" > /dev/null
printf "\n%s\n" "Testing is complete. The device is resetting and rebooting."

exit
