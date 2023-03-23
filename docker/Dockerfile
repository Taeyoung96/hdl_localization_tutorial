# Dockerfile for hdl_localization
# Author : Taeyoung Kim (https://github.com/Taeyoung96)

FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu18.04

# Install ROS melodic
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    dirmngr \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*

# setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu bionic main" > /etc/apt/sources.list.d/ros1-latest.list

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV ROS_DISTRO melodic

# Fix bug for timezone ref: https://grigorkh.medium.com/fix-tzdata-hangs-docker-image-build-cdb52cc3360d 
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# install ros packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-melodic-desktop-full=1.4.1-0* \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install --no-install-recommends -y wget nano git build-essential \
    libgtest-dev libomp-dev libboost-all-dev libopencv-dev ros-melodic-pcl-ros ros-melodic-rviz \
    ros-melodic-tf2 ros-melodic-tf2-ros ros-melodic-tf2-geometry-msgs ros-melodic-image-transport ros-melodic-image-transport-plugins \
    ros-melodic-eigen-conversions ros-melodic-tf-conversions python3 python3-pip python3-venv \
    ros-melodic-cv-bridge ros-melodic-message-filters wget \
    libatlas-base-dev libgoogle-glog-dev libsuitesparse-dev libglew-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install ceres-solver
WORKDIR /root/thirdParty
RUN wget https://github.com/ceres-solver/ceres-solver/archive/refs/tags/1.14.0.tar.gz
RUN tar zxf 1.14.0.tar.gz
RUN cd ceres-solver-1.14.0
RUN mkdir build && cd build
RUN cmake -DCMAKE_BUILD_TYPE=Release ./ceres-solver-1.14.0 && make -j2 && make install

# Catkin workspace initializaiton
RUN mkdir -p /root/catkin_ws/src
WORKDIR /root/catkin_ws/src
RUN /bin/bash -c '. /opt/ros/melodic/setup.bash; catkin_init_workspace' 

# Load ROS environment at each run
COPY ./ros_entrypoint.sh /
RUN chmod 755 /ros_entrypoint.sh
ENTRYPOINT ["/ros_entrypoint.sh"]

CMD ["bash"]
