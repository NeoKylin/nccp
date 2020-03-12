FROM cs2cdocker/origin-base:v3.9.0
MAINTAINER Dapeng <kunpeng.wu@cs2c.com.cn>

ADD ./ns7-mips.repo /etc/yum.repos.d/

RUN INSTALL_PKGS="origin-service-catalog" && \
    yum clean all && \
    yum install -y ${INSTALL_PKGS} && \
    yum update -y && \
    rpm -V ${INSTALL_PKGS} && \
    yum clean all && \
    rm -rf /usr/share/doc/ /usr/share/man/ /var/cache/yum/

LABEL org.label-schema.build-date=20181020

CMD [ "/usr/bin/service-catalog" ]
