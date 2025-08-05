# FROM mono:latest
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

USER root

# Install dependencies for X11 + OpenGL rendering
RUN apt-get update && apt-get install -y \
    x11-apps \
    mesa-utils \
    libgl1-mesa-dri \
    libgl1-mesa-glx \
    sudo \
    curl \
    wget \
    unzip \
    libxcursor1 \
    libxkbcommon0 \
    libxinerama1 \
    libxrandr2 \
    libasound2 \
    libpulse0 \
    pulseaudio \
    libxi6 \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN rm packages-microsoft-prod.deb

RUN apt-get update && \
    apt-get install -y dotnet-sdk-8.0

RUN wget https://github.com/godotengine/godot/releases/download/4.4.1-stable/Godot_v4.4.1-stable_mono_linux_x86_64.zip

RUN mkdir ~/.cache \
    && mkdir -p ~/.config/godot \
    && mkdir -p ~/.config/godot/GodotSharp \
    && mkdir -p /usr/local/bin/godot/GodotSharp

RUN unzip Godot_v4.4.1-stable_mono_linux_x86_64.zip

RUN usermod -aG audio root

# Add this to your Dockerfile before the ENTRYPOINT
ARG UID=1000
ARG GID=1000

RUN groupadd -g ${GID} appgroup \
    && useradd -m -u ${UID} -g ${GID} appuser \
    && echo "appuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN usermod -aG audio appuser


# ENTRYPOINT [ "Godot_v4.4.1-stable_mono_linux_x86_64/Godot_v4.4.1-stable_mono_linux.x86_64" ]

COPY godot-entrypoint.sh /usr/local/bin/godot-entrypoint.sh
RUN chmod +x /usr/local/bin/godot-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/godot-entrypoint.sh"]