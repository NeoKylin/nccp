#!/usr/bin/env bash

if [ ! -n "$1" ]; then
    echo ""
    echo "********************************************"
    echo "    此脚本用作制作(升级) NCCP 的主要镜像"
    echo "********************************************"
    echo ""
    echo "确认无误后执行"
    echo "      ./Update-NCCP-Images.sh OK"
    echo ""
    echo ""
    echo ""
    exit
fi

enable=1

BACKUP_DATE=`date +%Y%m%d%H`
#BACKUP_DATE=2018101214
echo -e "\033[34m[INFO] BACKUP_DATE\033[0m = \033[34m$BACKUP_DATE\033[0m"
BACKUPTAG_V=v3.9.0-$BACKUP_DATE
BACKUPTAG_L=latest-$BACKUP_DATE
echo -e "\033[34m[INFO] BACKUPTAG_V\033[0m = \033[34m$BACKUPTAG_V\033[0m"
echo -e "\033[34m[INFO] BACKUPTAG_L\033[0m = \033[34m$BACKUPTAG_L\033[0m"
echo


if [ $enable -eq 1 ]; then
    echo -e "\033[34m[INFO] install package\033[0m : \033[34mdocker\033[0m"
    yum install docker -y
    echo
    echo -e "\033[34m[INFO] check service docker status\033[0m"
    systemctl status docker
    if !([ "`echo $?`" = 0 ]); then
        echo -e "\033[34m[WARNING] service docker is not running\033[0m"
        echo -e "\033[34m[WARNING] try to restart service docker\033[0m"
        #sed -i '/OPTIONS=.*/c\OPTIONS="--signature-verification=False --insecure-registry 10.1.60.33:5550"' /etc/sysconfig/docker
        systemctl restart docker
        systemctl status docker
        if !([ "`echo $?`" = 0 ]); then
            echo "\033[31m[ERROR] failed to restart service docker !! \033[0m"
            echo "\033[31m[ERROR] EXIT \033[0m"
            exit
        fi
    fi

    # tag 为 v3.9.0 的镜像
    NCCPimageNAME_V=(
    origin-base
    origin
    origin-deployer
    node
    openvswitch
    origin-template-service-broker
    origin-web-console
    origin-pod
    origin-haproxy-router
    origin-service-catalog
    origin-docker-registry
    origin-sti-builder
    )
    
    # tag 为 latest 的镜像
    NCCPimageNAME_L=(
    ansibleplaybookbundle_origin-ansible-service-broker
    cockpit_kubernetes
    )


    for image in ${NCCPimageNAME_V[@]}
    do
        echo
        echo -e "\033[34m[INFO] Build image\033[0m : \033[34m$image\033[0m"
        cd cs2cdocker/$image/
        echo "pwd : `pwd`"
        docker build -t cs2cdocker/$image:$BACKUPTAG_V .
        if [ "`echo $?`" = 0 ]; then
            docker tag cs2cdocker/$image:$BACKUPTAG_V cs2cdocker/$image:v3.9.0
            cd ../../
        else
            echo -e "\033[31m[ERROR] Failed to build image\033[0m : \033[31mcs2cdocker/$image:$BACKUPTAG_V\033[0m"
            echo
            exit
        fi
        #docker images
    done
    
    for image in ${NCCPimageNAME_L[@]}
    do
        echo
        echo -e "\033[34m[INFO] Build image\033[0m : \033[34m$image\033[0m"
        cd cs2cdocker/$image/
        echo "pwd : `pwd`"
        docker build -t cs2cdocker/$image:$BACKUPTAG_L .
        if [ "`echo $?`" = 0 ]; then
            docker tag cs2cdocker/$image:$BACKUPTAG_L cs2cdocker/$image:latest
            cd ../../
        else
            echo -e "\033[31m[ERROR] Failed to build image\033[0m : \033[31mcs2cdocker/$image:$BACKUPTAG_V\033[0m"
            echo
            exit
        fi
    done

fi



echo 
echo "BACKUP_DATE = $BACKUP_DATE"
echo 

