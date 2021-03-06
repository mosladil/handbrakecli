#!/bin/sh

from=MOV
to=mp4

cmd=/Applications/HandBrakeCLI
[ -x ${cmd} ] || exit 1

echo "Starting conversion from ${from} to ${to}"

for x in $(find . -type f -name \*.${from})
do
    input=${x}
    output=${input%.*}.${to}
    [ -e ${output} ] && continue;
    echo ""
    echo "Processing ${input} to ${output}"
    ${cmd} \
	-i ${input} \
	-o ${output} \
	--encoder x264 \
	--deinterlace \
	--detelecine \
	--decomb \
	--loose-anamorphic \
	--quality 20.0 \
	--rate 25 \
	--aencoder aac,ac3 \
	--arate 48 \
	--pfr \
    2> /dev/null
    [ $? == 0 ] && mv ${input} ~/.Trash
done
