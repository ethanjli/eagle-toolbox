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

RUN   ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \ 
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/transactional-update

# Download Eagle
RUN wget -P /opt/ https://eagle-updates.circuits.io/downloads/9_6_2/Autodesk_EAGLE_9.6.2_English_Linux_64bit.tar.gz && \
    tar -xzf /opt/Autodesk_EAGLE_9.6.2_English_Linux_64bit.tar.gz -C /opt && \
    mv /opt/eagle-9.6.2 /opt/eagle

# Patch Eagle based on the instructions at
# https://forums.autodesk.com/t5/eagle-forum/running-eagle-on-fedora-33-dialogs-fail-display-properly-appears/m-p/10374674/highlight/true#M34418
RUN rm -r /opt/eagle/lib/libQt* && \
    rm -r /opt/eagle/plugins && \
    rm /opt/eagle/qt.conf && \
    rm /opt/eagle/libexec/QtWebEngineProcess && \
    rm /opt/eagle/libexec/qt.conf

COPY prepare-eagle /usr/bin/
COPY com.autodesk.Eagle.desktop /usr/share/applications/
COPY com.autodesk.Eagle.png /usr/share/icons/hicolor/128x128/apps/
