#!/bin/bash

#usage: ssh USER@FINAL_DEST -o "ProxyCommand=nc -X connect -x PROXY:PROXYPORT %h %p"
#pcon ssh USER@FINAL_DEST
#pcon scp USER@FINAL_DEST [FROM] [TO]
#future:
#pcon ssh USER@FINAL_DEST -pp PROXY:PROXYPORT

proxy=" "

tempary=()
#declare -a tempary
pflag=0

for i in $@; do
  if [ $i == '-p' ]; then
    pflag=1
  elif [ $pflag -eq 1 ]; then
    pflag=0
    proxy=$i
  else
    tempary+="$i "
  fi
done

trmary=("-o \"ProxyCommand=nc -X connect -x " $proxy " %h %p\"")

if [ $1="ssh" ]; then
  trmthng=("${tempary[@]:0:1}" "${trmary[@]}" "${tempary[@]:2}")
elif [ $1="scp" ]; then
  trmthng=("${tempary[@]}" "${trmary[@]}")
else
  echo "not supported at this time"
  exit
fi

echo ${trmthng[@]}
eval ${trmthng[@]}
