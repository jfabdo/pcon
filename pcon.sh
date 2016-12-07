#! /bin/bash

#usage: ssh USER@FINAL_DEST -o "ProxyCommand=nc -X connect -x PROXY:PROXYPORT %h %p"
#pcon ssh USER@FINAL_DEST
#pcon scp USER@FINAL_DEST [FROM] [TO]
#future:
#pcon ssh USER@FINAL_DEST -pp PROXY:PROXYPORT

proxy="indyzproxy.am.thmulti.com:80"

tempary=()
pflag=false
for i in $@; do
  if [ $i='-p' ]; then
    pflag=true
  elif [ $pflag ]; then
    pflag=false
    proxy=$i
  else
    tempary+=$i
  fi

done

unset tempary[0]
trmary=("-o \"ProxyCommand=nc -X connect -x " $proxy " %h %p\"")

if [ $1="ssh" ]; then
  unset tempary[1]#wackyslappyhackytaffy
  unset tempary[2]
  trmthng=($1 $2 "${trmary[@]}" "${tempary[@]}")
elif [ $1="scp" ]; then
  trmthng=("${tempary[@]}" "${trmary[@]}")
else
  echo "not supported at this time"
  exit
fi

echo ${trmthng[@]}
eval ${trmthng[@]}
