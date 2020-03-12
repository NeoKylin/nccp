#
# This is the official OpenShift Origin pod infrastructure image. It will stay running
# until terminated by a signal and is the heart of each running pod. It holds on to
# the network and IPC namespaces as containers come and go during the lifetime of the
# pod.
#
# The standard name for this image is openshift/origin-pod
#
FROM cs2cdocker/origin-base:v3.9.0
MAINTAINER Dapeng <kunpeng.wu@cs2c.com.cn>

ADD ./ns7-mips.repo /etc/yum.repos.d/

RUN INSTALL_PKGS="origin-pod" && \
    yum clean all && \
    yum install -y ${INSTALL_PKGS} && \
    yum update -y && \
    rpm -V ${INSTALL_PKGS} && \
    yum clean all

LABEL io.k8s.display-name="OpenShift Origin Pod Infrastructure" \
      io.k8s.description="This is a component of OpenShift Origin and holds on to the shared Linux namespaces within a Pod." \
      io.openshift.tags="openshift,pod" \
      org.label-schema.build-date=20181020

USER 1001
ENTRYPOINT ["/usr/bin/pod"]
