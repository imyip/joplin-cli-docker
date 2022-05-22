#!/bin/sh
set -e

echo "*/30 * * * * /usr/local/bin/joplin sync" >/etc/crontabs/root

socat TCP4-LISTEN:41182,fork TCP4:127.0.0.1:41184 &

if [ -f "/joplin/profile/options.json" ]; then
   /usr/local/bin/joplin config --import-file /joplin/profile/options.json
   /usr/local/bin/joplin sync
fi

/usr/local/bin/joplin --profile /joplin/profile &
/usr/local/bin/joplin server start
