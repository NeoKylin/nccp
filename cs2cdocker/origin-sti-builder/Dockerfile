#
# This is the image that executes a S2I build inside Origin. It expects the
# following environment variables:
#
#   BUILD - JSON string containing the openshift build object
#
# This image expects to have the Docker socket bind-mounted into the container.
# If "/root/.dockercfg" is bind mounted in, it will use that as authorization to a
# Docker registry.
#
# The standard name for this image is cs2cdocker/origin-sti-builder
#
FROM cs2cdocker/origin:v3.9.0

LABEL io.k8s.display-name="NCCP Origin S2I Builder" \
      io.k8s.description="This is a component of NCCP Origin and is responsible for executing source-to-image (s2i) image builds." \
      io.openshift.tags="openshift,sti,builder"

ENTRYPOINT ["/usr/bin/openshift-sti-build"]
