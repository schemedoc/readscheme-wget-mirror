#!/bin/sh
set -eu
cd "$(dirname "$0")"
cd ..
echo "Entering directory '$PWD'"

# 404 cite.ss (a server-side script)
# 404 /partial-eval/events/imgs/dot_clear.gif
# 404 /partial-eval/journals/imgs/dot_clear.gif

download() {
    hostname="$1"

    echo "Download $hostname"
    mkdir "www/$hostname"
    (cd www &&
        wget \
            --mirror "http://$hostname/" \
            --reject cite.ss \
            --reject-regex '/partial-eval/[^/]+/imgs/dot_clear.gif' \
            >"../misc/$hostname.log" 2>&1)
    git add misc www
    git commit -m "Download $hostname"
}

mkdir misc www
download www.readscheme.org
download library.readscheme.org
