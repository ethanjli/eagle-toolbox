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

RUN curl -sS https://starship.rs/install.sh | sh -s -- --yes

RUN   ln -fs /bin/sh /usr/bin/sh && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \ 
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/transactional-update
     
COPY patch-eagle /usr/bin/
COPY com.autodesk.Eagle.desktop /usr/share/applications/
COPY com.autodesk.Eagle.png /usr/share/icons/hicolor/128x128/apps/
