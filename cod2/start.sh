#!/bin/bash

cd $(dirname $0)

if [ ! -e ./main/iw_13.iwd ]; then
	echo "Make sure you put all iw_*.iwd files from your CoD2 installation into the main directory!" 2>&1
	exit 1
fi

docker stop cod2 &>/dev/null
docker rm cod2 &>/dev/null

set -x

docker run \
	-v $(pwd)/main:/home/cod2/main \
	-itd --restart unless-stopped \
	--name cod2 \
	-p 20500:20500/udp \
        -p 20510:20510/udp \
	-p 28960:28960/tcp \
	-p 28960:28960/udp \
	bgauduch/cod2server:latest \
	+set net_port 28960 +set sv_cheats 0 +set sv_punkbuster 0 +exec punkbuster.cfg +exec server_mp.cfg
