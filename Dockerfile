FROM osrf/ros:kinetic-desktop-full-xenial

ARG VNC_PASSWORD=secret
ENV VNC_PASSWORD=${VNC_PASSWORD} \
    DEBIAN_FRONTEND=noninteractive
WORKDIR /root

RUN apt-get update; \
    apt-get install -y libgl1-mesa-glx libgl1-mesa-dri mesa-utils \
        dbus-x11 x11-utils x11vnc xvfb supervisor \
        dwm suckless-tools dmenu stterm; \
    rosdep init; rosdep update; \
    echo "source /opt/ros/kinetic/setup.bash" >> /root/.bashrc; \
    mkdir -p /etc/supervisor/conf.d; \
    x11vnc -storepasswd $VNC_PASSWORD /etc/vncsecret; \
    chmod 444 /etc/vncsecret; \
    apt-get autoclean; \
    apt-get autoremove; \
    rm -rf /var/lib/apt/lists/*; 

COPY supervisord.conf /etc/supervisor/conf.d
EXPOSE 5900
CMD ["/usr/bin/supervisord","-c","/etc/supervisor/conf.d/supervisord.conf"]
