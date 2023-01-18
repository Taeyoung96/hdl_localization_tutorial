FROM ros:melodic

RUN apt-get update && apt-get install --no-install-recommends -y \
    && apt-get install --no-install-recommends -y wget nano build-essential \
    libgtest-dev libomp-dev libboost-all-dev libopencv-dev ros-melodic-pcl-ros \
    ros-melodic-tf2 ros-melodic-tf2-ros ros-melodic-tf2-geometry-msgs \
    ros-melodic-eigen-conversions ros-melodic-tf-conversions \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/catkin_ws/src
WORKDIR /root/catkin_ws/src
RUN /bin/bash -c '. /opt/ros/melodic/setup.bash; catkin_init_workspace'
 
WORKDIR /root/catkin_ws
RUN /bin/bash -c '. /opt/ros/melodic/setup.bash; catkin_make -DENABLE_TEASER=OFF'
RUN sed -i "6i source \"/root/catkin_ws/devel/setup.bash\"" /ros_entrypoint.sh

WORKDIR /

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
