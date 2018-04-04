Pre-configure image to a ROS Gazebo workspace
======

This starts with the Ubuntu [Xenial](https://registry.hub.docker.com/_/ubuntu/) base image, and follows the install steps from
 [UUV](https://github.com/uuvsimulator/uuv_simulator/wiki) 
 to include ROS Lunar with Gazebo 9.


Quickstart
------

Specify your own VNC password for the container:

```
    clone https://github.com/shrmpy/gazebo.git && cd gazebo && \
    docker build --build-arg VNC_PASSWORD=MyPassGoesHere --network=host --add-host=$HOSTNAME:127.0.0.1 -t gazebo .
```

Run your container (e.g., with a mounted subdir to save screenshots):

```
    mkdir Pictures && docker run --network=host --rm -v $(pwd)/Pictures:/home/gopher/.gazebo/pictures gazebo
```


Connect with VNC viewer, and enter the VNC password from the step above when prompted:

```
    vncviewer vnc://localhost:5900
```


Once inside the container, start Gazebo:

```
    Shift-Alt-Enter                           #(hot-key st term)
    $ bash                                    #(bash shell to dot-source)
    $ roslaunch gazebo_ros empty_world.launch
```


