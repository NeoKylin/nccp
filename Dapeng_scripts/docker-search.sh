#!/bin/sh
# Dapeng 2018-09-03
# search docker images from private registry

if [ ! -n "$1" ]; then
    echo ""
    echo "This script help you search docker images from private registry."
    echo "You must specify private registry URL "
    echo "Usage..."
    echo ""
    echo "	./docker-search.sh [private-registey_URL]"
    echo ""
    echo "eg:"
    echo "	./docker-search.sh 10.1.60.33:5550"
    echo ""
    exit
fi

PrivateRegisteyURL=$1
#echo "-------------------------------------------------------------------------"
#echo "private registey URL is : $PrivateRegisteyURL"
#echo "-------------------------------------------------------------------------"

[[ `curl -s $PrivateRegisteyURL/v2/_catalog` == "Failed connect" ]] && { echo -e "\033[31m$PrivateRegisteyURL 访问失败\033[0m";exit;}

Image=$(curl -s $PrivateRegisteyURL/v2/_catalog |jq .repositories |awk -F'"' '{for(i=1;i<=NF;i+=2)$i=""}{print $0}')
[[ $Image = "" ]] && { echo -e "\033[31m$HUB 没有docker镜像\033[0m";exit; }
for n in $Image;
  do
    curl -s http://$PrivateRegisteyURL/v2/$n/tags/list
  done
