# !/bin/bash

if [ ! -n "$1" ]; then
    echo ""
    echo "此脚本将从私有仓库下载镜像，以下内容请悉知："
    echo ""
    echo "    1.运行此脚本将修改系统配置文件 /etc/sysconfig/docker  并重启 docker 服务"
    echo -e "    2.运行此脚本前请\033[34m打开此脚本，检查registry_URL、BACKUP_DATE等信息是否正确\033[0m"
    echo ""
    echo "确认无误后执行"
    echo "      ./pull-from-private-registry.sh OK"
    echo ""
    exit
fi
# 检查以下内容是否无误：
registry_URL="10.1.60.33:5550"
BACKUP_DATE="2018101214"
sed -i '/OPTIONS=.*/c\OPTIONS="--signature-verification=False --insecure-registry 10.1.60.33:5550"' /etc/sysconfig/docker




systemctl restart docker
systemctl status docker
docker images


# ************************************************
#       do not change the following contents
PRE_NAME="cs2cdocker"
TAG_V="v3.9.0"
TAG_L="latest"
# ************************************************

# tag 为 v3.9.0 的镜像
NCCPimageNAME_V=(
node
openvswitch
origin-base
origin-deployer
origin-haproxy-router
origin-pod
origin-service-catalog
origin-template-service-broker
origin
origin-web-console
origin-docker-registry
origin-sti-builder
)

# tag 为 latest 的镜像
NCCPimageNAME_L=(
ansibleplaybookbundle_origin-ansible-service-broker
cockpit_kubernetes
)

num_dockerimages=(${#NCCPimageNAME_V[@]} + ${#NCCPimageNAME_L[@]})
echo $num_dockerimages

for image in ${NCCPimageNAME_V[@]}
do
    echo -e "\033[41;30mpulling image\033[0m : \033[40;37m$PRE_NAME/$image:$TAG_V-$BACKUP_DATE\033[0m"
    docker pull $registry_URL/$PRE_NAME/$image:$TAG_V-$BACKUP_DATE
    docker tag $registry_URL/$PRE_NAME/$image:$TAG_V-$BACKUP_DATE docker.io/$PRE_NAME/$image:$TAG_V
    docker rmi $registry_URL/$PRE_NAME/$image:$TAG_V-$BACKUP_DATE
    echo
done

for image in ${NCCPimageNAME_L[@]}
do
    echo -e "\033[41;30mpulling image\033[0m : \033[40;37m$PRE_NAME/$image:$TAG_L-$BACKUP_DATE\033[0m"
    docker pull $registry_URL/$PRE_NAME/$image:$TAG_L-$BACKUP_DATE
    docker tag $registry_URL/$PRE_NAME/$image:$TAG_L-$BACKUP_DATE docker.io/$PRE_NAME/$image:$TAG_L
    docker rmi $registry_URL/$PRE_NAME/$image:$TAG_L-$BACKUP_DATE
    echo
done

docker images
