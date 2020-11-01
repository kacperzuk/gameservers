#!/bin/bash

cd "$(dirname "$0")"

if [ ! -e data/System/ucc-bin ]; then
	echo "Enter your Steam login - required to download server:"
	read steamuser
	./update.sh $steamuser || exit 1
fi

docker stop kf2 &>/dev/null
docker rm kf2 &>/dev/null

docker run -itd --restart=unless-stopped \
	--name kf2 \
	-v $(pwd)/data:/data \
	-p 7707:7707/udp \
	-p 7707:7707/tcp \
	-p 7708:7708/udp \
	-p 7708:7708/tcp \
	-p 28852:28852/udp \
	-p 28852:28852/tcp \
	-p 8075:8075/tcp \
	-p 20560:20560/udp \
	--entrypoint /bin/sh \
	-w /data/System/ \
	steamcmd/steamcmd:latest \
	ucc-bin server KF-WestLondon.rom?game=KFmod.KFGameType?VACSecured=true?MaxPlayers=6
