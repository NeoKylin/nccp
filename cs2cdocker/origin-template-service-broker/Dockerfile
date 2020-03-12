FROM cs2cdocker/neokylin:7
MAINTAINER Dapeng <kunpeng.wu@cs2c.com.cn>

RUN INSTALL_PKGS="origin-template-service-broker" && \
    yum clean all && \
    yum install -y ${INSTALL_PKGS} && \
    rpm -V ${INSTALL_PKGS} && \
    yum update -y && \
    yum clean all && \
    rm -rf /usr/share/doc/ /usr/share/man/ /var/cache/yum/

CMD [ "/usr/bin/template-service-broker" ]
