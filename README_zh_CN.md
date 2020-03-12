# NCCP

[English](./README.md) ｜ 简体中文

 NeoKylin Container Cloud Platform Dockerfiles

 中标麒麟容器云平台 Dockerfiles

源自开源镜像。

修改者
------
Dapeng-W <kunpeng.wu@cs2c.com.cn>


文档
----
正在完成...


使用注解
--------
### ***简单说明*** 

 `Update-NCCP-Images.sh` 为龙芯平台NCCP基础镜像升级脚本，
 基于中标麒麟服务器操作系统V7.0（龙芯版-64位）系统环境。

如果`origin`、`origin-web-console`等相关软件包有新的修改提交，则需要进行NCCP基础镜像升级。


### ***运行脚本前请确保dockerhub上，下列已有NCCP基础镜像（同名的旧版本）均已做好备份：*** 

    cs2cdocker/ansibleplaybookbundle_origin-ansible-service-broker:latest
    cs2cdocker/cockpit_kubernetes:latest
    cs2cdocker/node:v3.9.0
    cs2cdocker/openvswitch:v3.9.0
    cs2cdocker/origin-base:v3.9.0
    cs2cdocker/origin-deployer:v3.9.0
    cs2cdocker/origin-docker-registry:v3.9.0
    cs2cdocker/origin-haproxy-router:v3.9.0
    cs2cdocker/origin-pod:v3.9.0
    cs2cdocker/origin-service-catalog:v3.9.0
    cs2cdocker/origin-sti-builder:v3.9.0
    cs2cdocker/origin-template-service-broker:v3.9.0
    cs2cdocker/origin:v3.9.0
    cs2cdocker/origin-web-console:v3.9.0



### ***具体备份形式有3种，任选：*** 

 （1）将备份镜像上传至dockerhub进行备份，例如：
 
    docker pull cs2cdocker/node:v3.9.0
    docker login
    docker tag cs2cdocker/node:v3.9.0 cs2cdocker/node:v3.9.0-backup20200312
    docker push cs2cdocker/node:v3.9.0-backup20200312
   
 注意：备份tag不应和dockerhub上的已有镜像相同！

 如果你不是NeoKylin的开发维护人员，建议：
 
    docker pull cs2cdocker/node:v3.9.0
    docker login
    docker tag cs2cdocker/node:v3.9.0 <yourdockerhubname>/node:v3.9.0-backup20200312
    docker push <yourdockerhubname>/node:v3.9.0-backup20200312
 

 （2）将备份镜像上传至私有镜像仓库服务器（可能是一台harbor镜像仓库服务器），例如：
 
    docker pull cs2cdocker/node:v3.9.0
    docker login <server>
    docker tag cs2cdocker/node:v3.9.0 <server>/cs2cdocker/node:v3.9.0-backup20200312
    docker push <server>/cs2cdocker/node:v3.9.0-backup20200312
    

（3）将备份镜像保存为tar包，例如：

    docker pull cs2cdocker/node:v3.9.0
    docker save -o node390-20200312.tar cs2cdocker/node:v3.9.0-backup20200312


### ***注意事项*** 

 运行脚本升级镜像前请确保本地(镜像构建环境)无相关镜像.

 否则`docker build`可能会使用本地缓存。

 在此脚本仓库的部分目录下，有些 `ns7-mips.repo` 文件可根据实际软件仓库路径情况作修改，不予赘述。

 Dockerfile也可能需要根据实际情况调整，不予赘述。


### ***寻一个干净的龙芯服务器系统环境，开始构建（升级）镜像*** 

    yum install docker -y
    syatemctl start docker
    ./Update-NCCP-Images.sh OK


### ***镜像构建完成之后*** 

 镜像构建完成后，可上传至dockerhub，步骤参考前述之 [备份形式](https://github.com/Dapeng-W/nccp/blob/master/README_zh_CN.md#%E5%85%B7%E4%BD%93%E5%A4%87%E4%BB%BD%E5%BD%A2%E5%BC%8F%E6%9C%893%E7%A7%8D%E4%BB%BB%E9%80%89)（1）

 上传前确保dockerhub上原有的同名、同tag的镜像已做好备份。


