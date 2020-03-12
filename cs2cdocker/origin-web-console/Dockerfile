# docker build -t cs2cdocker/origin-web-console:$BACKUPTAG1 .
FROM cs2cdocker/origin-base:v3.9.0
MAINTAINER Dapeng <kunpeng.wu@cs2c.com.cn>

ADD ./ns7-mips.repo /etc/yum.repos.d/

RUN INSTALL_PKGS="origin-web-console" && \
    yum clean all && \
    yum install -y ${INSTALL_PKGS} && \
    yum update -y && \
    rpm -V ${INSTALL_PKGS} && \
    yum clean all && \
    rm -rf /usr/share/doc/ /usr/share/man/ /var/cache/yum/

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

LABEL io.openshift.tags="openshift"\
      org.label-schema.build-date=20181020

ENTRYPOINT ["/usr/bin/origin-web-console"]

EXPOSE 5000 443 53
