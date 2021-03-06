#
# This is an openvswitch image meant to enable OpenShift OVS based SDN
#
# The standard name for this image is openshift/openvswitch
#
FROM cs2cdocker/node:v3.9.0
MAINTAINER Dapeng <kunpeng.wu@cs2c.com.cn>

COPY scripts/* /usr/local/bin/
RUN INSTALL_PKGS="openvswitch" && \
    yum clean all && \
    yum install -y ${INSTALL_PKGS} && \
    yum update -y && \
    rpm -V ${INSTALL_PKGS} && \
    yum clean all

LABEL io.openshift.tags="openshift,openvswitch" \
      io.k8s.display-name="OpenShift Origin OpenVSwitch Daemon" \
      io.k8s.description="This is a component of OpenShift Origin and runs an OpenVSwitch daemon process." \
      org.label-schema.build-date=20181020

VOLUME /etc/openswitch
ENV HOME /root

# files required to run as a system container
COPY system-container/system-container-wrapper.sh /usr/local/bin/
COPY system-container/config.json.template system-container/service.template system-container/tmpfiles.template system-container/manifest.json /exports/

ENTRYPOINT ["/usr/local/bin/ovs-run.sh"]
