#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

DIR="$( cd -P "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd )"

cd $DIR

filelist() {
    find . -type f -name '*.jpg' -not -name '*thumb*'
}


filelist | while read file; do
    set -x
    convert -quality 85 -resize 1920 $file $(basename $file .jpg)-thumb.jpg
    set +x
done

exit 0
