FROM ubuntu:24.04
# ubuntu:24.04 | debian:13 | fedora:44

ARG FLUTTER_VERSION=3.35.7

ENV DEBIAN_FRONTEND=noninteractive
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
# amd64 | arm64
ENV ANDROID_HOME=/opt/android-sdk
ENV ANDROID_SDK_ROOT=/opt/android-sdk
ENV PATH="${PATH}:/opt/flutter/bin:/opt/android-sdk/cmdline-tools/latest/bin:/opt/android-sdk/platform-tools:/root/.pub-cache/bin"
ENV ANDROID_SDK_VERSION=11076708

# for ubuntu
#RUN apt-get update && apt-get install -y \
#    git curl unzip xz-utils zip clang cmake ninja-build \
#    libgtk-3-dev libayatana-appindicator3-dev libfuse2 \
#    libmpv-dev mpv libmimalloc-dev libmimalloc2.0 openjdk-17-jdk \
#    ca-certificates patchelf rpm build-essential fakeroot \
#    && rm -rf /var/lib/apt/lists/*

# for debian
#RUN apt-get update && apt-get install -y \
#    git curl unzip xz-utils zip clang cmake ninja-build \
#    libgtk-3-dev libayatana-appindicator3-dev\
#    libmpv-dev mpv libmimalloc-dev \
#    ca-certificates patchelf rpm build-essential fakeroot \
#    && rm -rf /var/lib/apt/lists/*

# for fedora
#RUN dnf -y update && dnf install -y \
#    git curl unzip xz zip clang cmake ninja-build \
#    gtk3-devel libayatana-appindicator3-devel fuse3-libs \
#    mpv mpv-devel mimalloc-devel which \
#    ca-certificates patchelf rpm-build @development-tools fakeroot \
#    && dnf clean all

RUN git clone https://github.com/flutter/flutter.git /opt/flutter \
&& cd /opt/flutter \
&& git checkout ${FLUTTER_VERSION} \
&& flutter config --enable-linux-desktop \
&& dart pub global activate fastforge

# for ubuntu
RUN mkdir -p /opt/android-sdk/cmdline-tools \
    && cd /tmp \
    && curl -fsSL https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_VERSION}_latest.zip -o cmdline-tools.zip \
    && unzip cmdline-tools.zip \
    && mv cmdline-tools /opt/android-sdk/cmdline-tools/latest \
    && rm cmdline-tools.zip