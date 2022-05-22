#!/bin/sh
set -e

chown root:root /etc/crontabs/root && echo "*/30 * * * * /usr/local/bin/joplin sync" > /etc/crontabs/root && /usr/sbin/crond 

if [ -f "/joplin/profile/options.json" ]; then
   /usr/local/bin/joplin config --import-file /joplin/profile/options.json --profile /joplin/profile
   /usr/local/bin/joplin sync --profile /joplin/profile
fi

/usr/local/bin/joplin server start --profile /joplin/profile
