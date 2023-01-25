# Dockerfile for HDL localization
# Author : Taeyoung Kim (https://github.com/Taeyoung96)

FROM ros:melodic

RUN apt-get update && apt-get install --no-install-recommends -y wget nano git build-essential \
    libgtest-dev libomp-dev libboost-all-dev libopencv-dev ros-melodic-pcl-ros ros-melodic-rviz \
    ros-melodic-tf2 ros-melodic-tf2-ros ros-melodic-tf2-geometry-msgs \
    ros-melodic-eigen-conversions ros-melodic-tf-conversions \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Fast-GICP (https://github.com/SMRT-AIST/fast_gicp)
WORKDIR /root/
RUN git clone https://github.com/SMRT-AIST/fast_gicp --recursive
RUN mkdir -p /root/fast_gicp/build
WORKDIR /root/fast_gicp/build
RUN cmake -DCMAKE_INSTALL_PREFIX=/usr ..
RUN make -j4
RUN make install

RUN mkdir -p /root/catkin_ws/src
WORKDIR /root/catkin_ws/src
RUN /bin/bash -c '. /opt/ros/melodic/setup.bash; catkin_init_workspace'
 
WORKDIR /root/catkin_ws
RUN /bin/bash -c '. /opt/ros/melodic/setup.bash; catkin_make -DENABLE_TEASER=OFF'
RUN sed -i "6i source \"/root/catkin_ws/devel/setup.bash\"" /ros_entrypoint.sh

WORKDIR /

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
