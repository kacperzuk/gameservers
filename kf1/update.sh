#!/bin/bash

cd "$(dirname "$0")"

if [ $# -lt 1 ]; then
	echo "Usage: $0 <steam_login>" 2>&1
	exit 1
fi

docker pull steamcmd/steamcmd:latest

VALIDATE=""

if [ ! -e data ]; then
	VALIDATE="validate"
fi

set -x
exec docker run --rm -it -v $(pwd)/data:/data steamcmd/steamcmd:latest +login "$1" +force_install_dir /data +app_update 215360 $validate +quit
