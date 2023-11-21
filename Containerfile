FROM quay.io/toolbx-images/ubuntu-toolbox:22.04

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A Distrobox image for running Autodesk Eagle" \
      maintainer="lietk12@gmail.com"

COPY toolbox-packages /
RUN apt-get update && \
    apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
        $(grep -v '^#' /toolbox-packages | xargs) && \
    rm -rd /var/lib/apt/lists/*
RUN rm /toolbox-packages

RUN curl -sS https://starship.rs/install.sh | sh -- --yes

RUN   ln -fs /bin/sh /usr/bin/sh && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \ 
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/transactional-update
     
COPY patch-eagle /usr/local/bin/
RUN mkdir -p /usr/local/share/applications
COPY com.autodesk.Eagle.desktop /usr/local/share/applications/
RUN chmod a+r /usr/local/share/applications/com.autodesk.Eagle.desktop
RUN mkdir -p /usr/share/icons/Eagle
COPY com.autodesk.Eagle.png /usr/share/icons/Eagle

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen
