FROM cs2cdocker/neokylin:7
MAINTAINER Dapeng <kunpeng.wu@cs2c.com.cn>

RUN INSTALL_PKGS=" \
      which git tar wget hostname sysvinit-tools util-linux bsdtar \
      socat ethtool device-mapper iptables tree findutils nmap-ncat e2fsprogs \
      xfsprogs lsof device-mapper-persistent-data ceph-common \
      bind-utils systemd GeoIP hostname iputils lsof lz4 passwd pkgconfig \ 
      rootfiles socat tar tree sysvinit-tools dbus-python wget \ 
      gobject-introspection libxml2-python  shared-mime-info \
      yum-utils yum-plugin-ovl python-gobject-base" && \
      yum clean all && \
      yum install -y --setopt=tsflags=nodocs ${INSTALL_PKGS} && \
      yum update -y && \
      yum clean all

LABEL org.label-schema.schema-version=1.0 \
      org.label-schema.name="NCCP Base Image"  \
      org.label-schema.vendor=CS2C  \
      org.label-schema.license=GPLv2  \
      org.label-schema.build-date=20181020

CMD ["/bin/bash"]
