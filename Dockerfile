FROM tensorflow/tensorflow:latest-gpu-jupyter

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y && \
  apt install -y \
    build-essential \
    wget \
    curl \
    vim \
    ant \
    default-jdk \
    unzip \
    supervisor \
    sudo \
    usbutils \
    xfce4 \
    xfce4-terminal \
    desktop-base \
    xscreensaver

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

WORKDIR /experimental

RUN wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN wget https://github.com/Eugeny/tabby/releases/download/v1.0.145/tabby-1.0.145-linux.deb

RUN yes | dpkg --install chrome-remote-desktop_current_amd64.deb || true
RUN apt install -y --fix-broken

RUN yes | dpkg --install tabby-1.0.145-linux.deb || true
RUN apt install -y --fix-broken

RUN yes | dpkg --install google-chrome-stable_current_amd64.deb || true
RUN apt install -y --fix-broken

RUN echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session

RUN useradd -ms /bin/bash developer

RUN usermod -aG sudo developer

ENTRYPOINT ["tail", "-f", "/dev/null"]

