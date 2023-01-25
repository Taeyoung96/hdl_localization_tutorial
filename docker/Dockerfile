# Dockerfile for HDL localization
# Author : Taeyoung Kim (https://github.com/Taeyoung96)

FROM ros:melodic

RUN apt-get update && apt-get install --no-install-recommends -y wget nano git build-essential \
    libgtest-dev libomp-dev libboost-all-dev libopencv-dev ros-melodic-pcl-ros ros-melodic-rviz \
    ros-melodic-tf2 ros-melodic-tf2-ros ros-melodic-tf2-geometry-msgs \
    ros-melodic-eigen-conversions ros-melodic-tf-conversions \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


RUN mkdir -p /root/catkin_ws/src
WORKDIR /root/catkin_ws/src
RUN /bin/bash -c '. /opt/ros/melodic/setup.bash; catkin_init_workspace'
 

# Load ROS environment at each run
COPY ./ros_entrypoint.sh /
RUN chmod 755 /ros_entrypoint.sh
ENTRYPOINT ["/ros_entrypoint.sh"]

CMD ["bash"]
