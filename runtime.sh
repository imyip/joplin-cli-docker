#!/bin/sh
set -e

chown root:root /etc/crontabs/root && echo "*/30 * * * * /usr/local/bin/joplin sync" > /etc/crontabs/root && /usr/sbin/crond 

socat TCP4-LISTEN:41182,fork TCP4:127.0.0.1:41184 &

if [ -f "/joplin/profile/options.json" ]; then
   /usr/local/bin/joplin config --import-file /joplin/profile/options.json
   /usr/local/bin/joplin sync
fi

/usr/local/bin/joplin --profile /joplin/profile server start 
