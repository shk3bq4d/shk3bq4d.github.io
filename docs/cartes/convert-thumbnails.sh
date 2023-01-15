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
    t="$(basename $file .jpg)"
    test -d "$t" || mkdir "$t"
    convert -quality 85 -resize 1920 "$file" "$t/${t}.jpg"
    cat << EOF > "$t/index.html"
<html><head><title>$t</title></head>
<body><img src="${t}.jpg" /></body>
</html>
EOF
done

exit 0
