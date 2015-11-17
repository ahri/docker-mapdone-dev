#!/bin/sh

set -uex

if [ $# -lt 4 ]; then
	echo "Usage: `basename "$0"` uid gid repo rake_task[ rake_task...]" 1>&2
	exit 1
fi

uid="$1"
gid="$2"
repo="$3"
shift 3

echo "devuser:x:$uid:$gid:Dev User:/tmp:/sbin/nologin" >> /etc/passwd
echo "devgroup:x:$gid:" >> /etc/group

su devuser -s /bin/sh -c "
	cd /tmp && \
    rm -rf repo && \
	GIT_SSH_COMMAND='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no' git clone '$repo' repo && \
	cd repo && \
	rake $@ \
	"
