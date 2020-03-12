# !/usr/bin/bash
if [ ! -n "$1" ]; then
    echo ""
    echo "此脚本用将修改openshift的用户认证模式，以下内容请悉知："
    echo ""
    echo "    1.请在 atomic-openshift-installer install 命令运行成功之后再执行此脚本"
    echo "    2.运行此脚本将修改系统配置文件 /etc/origin/master/master-config.yaml ,请做好备份"
    echo "    3.此脚本运行之后, 当请运行htpasswd 命令创建对应的 用户信息存储文件（ eg: /etc/origin/master/htpasswd ）"
    echo "    4.用户信息存储文件创建完成后，需手动重启 origin-master-api 服务"
    echo ""
    echo "确认无误后执行"
    echo "      ./htpasswd.sh OK"
    echo ""
    exit
fi

sed -i "s|kind: AllowAllPasswordIdentityProvider|kind: HTPasswdPasswordIdentityProvider|" /etc/origin/master/master-config.yaml
sed -i "/HTPasswdPasswordIdentityProvider/a\      file: /etc/origin/master/htpasswd" /etc/origin/master/master-config.yaml
