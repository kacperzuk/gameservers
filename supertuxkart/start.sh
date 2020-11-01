#!/bin/bash

docker stop supertuxkart &>/dev/null
docker rm supertuxkart &>/dev/null

echo -n "STK Username: "
read USER
echo -n "STK Password: "
read -s PASS
echo

docker run --name supertuxkart -itd \
             -p 2757:2757 \
             -p 2759:2759 \
             -v $(pwd)/config.xml:/app/config.xml \
             -e USERNAME=$USER \
             -e PASSWORD=$PASS \
             timoschwarzer/supertuxkart-server:latest
