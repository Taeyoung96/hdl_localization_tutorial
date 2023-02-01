# hdl_localization_tutorial

Step-by-step tutorial to facilitate hdl localization package with docker! :whale: 

## Result  


https://user-images.githubusercontent.com/41863759/215929963-17fd200c-8fe6-4be9-8302-249095dba087.mp4


## Requirement  
- [Docker](https://www.docker.com/)  
- [NVIDIA docker](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)
- [Sample Bag file](https://github.com/koide3/hdl_localization#example) : hdl_400.bag

## Tutorial Video  

If you're unfamiliar with docker, follow the tutorial video and run it step by step.  

<p align='center'>
  <a href="https://youtu.be/pxeU6HH5Gww">
    <img src="https://user-images.githubusercontent.com/41863759/215341195-f6240706-2ed0-4167-94cc-ad8a13070d85.png" alt="https://youtu.be/pxeU6HH5Gww" width="550"/>
  </a>
</p>


## How to start  

**1. Clone this repository. (Remember the path that you downloaded this repository)** 
```
git clone --recursive https://github.com/Taeyoung96/hdl_localization_tutorial.git
```

**2. Enter the `/docker` folder and make a docker image.**  
```
cd hdl_localization_tutorial/docker
```
```
docker build -t hdl_localization .
```

When you have finished it, use the command `docker images` and you can see the output below.  
```
REPOSITORY                   TAG                   IMAGE ID         CREATED          SIZE
hdl_localization             latest                338f71fd2fb3     12 seconds ago   2.37GB
```

**3. Make docker container**  

When you create a docker container, you need several options to use the GUI and share folders.

First, you should enter the command below in the local terminal to enable docker to communicate with Xserver on the host.

```
xhost +local:docker
```

After that, make your own container with the command below.

```
nvidia-docker run --privileged -it \
           -e NVIDIA_DRIVER_CAPABILITIES=all \
           -e NVIDIA_VISIBLE_DEVICES=all \
           --volume=/tmp/.X11-unix:/tmp/.X11-unix:rw \
           --net=host \
           --ipc=host \
           --shm-size=1gb \
           --env="DISPLAY=$DISPLAY" \
           --name=${docker container name} --volume=${hdl_localization_repo_root}:/root/catkin_ws/src ${docker image} /bin/bash
```

**:warning: You should change {hdl_localization_repo_root}, {docker container name}, {docker image} to suit your environment.**

If you have successfully created the docker container, the terminal output will be similar to the below.  

```
================Docker Env Ready================
root@taeyoung-cilab:/root/catkin_ws#
```

**4. Build hdl localization package and run it!**  

Four terminal windows are required.  
Two enter the docker container, and the other two are local terminals.  

Please run the roscore on one local terminal.  
```
roscore
```

Inside the docker container, run the build and run the package.  
```
catkin_make
```
```
source devel/setup.bash
```
```
rosparam set use_sim_time true
```
```
roslaunch hdl_localization hdl_localization.launch
```

Open another terminal and enter the docker container.  
```
docker exec -it -w /root/catkin_ws/ hdl_localization /bin/bash
```
Set up the environment on another terminal.  
```
source /opt/ros/melodic/setup.bash
```
Run rviz.  
```
cd src/hdl_localization/rviz
```
```
rviz -d hdl_localization.rviz
```

Run the sample bag file at the last local terminal.  
```
rosbag play hdl_400.bag  
```

Now, you could enjoy hdl_localization package! :smile:


## To do list 
- [ ] Support python3 & python script in Dockerfile.  

## Acknowldegement

Thanks to [koide3](https://github.com/koide3) for releasing the hdl_localization ros package.  
This repository follows the license of [hdl_localization](https://github.com/koide3/hdl_localization).  
