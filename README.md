# hdl_localization_collection

Step-by-step tutorial to facilitate hdl localization package.

## Requirement  
- [Docker](https://www.docker.com/)  
- [NVIDIA docker](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)

## How to start  

**1. Clone this repository. (Remember the path that you downloaded this repository)** 
```
git clone --recursive https://github.com/Taeyoung96/hdl_localization_collection.git
```

**2. Enter the `/docker` folder and make a docker image.**  
```
cd docker
```
```
docker build -t hdl_localization .
```

When you have finished it, use the command `docker images` and you can see the output below.  
```

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
           --volume=${hdl_localization_repo_root}:/root/catkin_ws/src \
           --volume=/tmp/.X11-unix:/tmp/.X11-unix:rw \
           --net=host \
           --ipc=host \
           --shm-size=1gb \
           --name=${docker container name} \
           --env="DISPLAY=$DISPLAY" \
           ${docker image} /bin/bash
```

**:warning: You should change {hdl_localization_repo_root}, {docker container name}, {docker image} to suit your environment.**

If you have successfully created the docker container, the terminal output will be similar to the below.  

```
================Docker Env Ready================
root@taeyoung-cilab:/root/catkin_ws#
```

**4. Build hdl localization package and run it!**  

Inside the docker container, run the build and run the package.  
```
catkin_make
```
```
source devel/setup.bash
```
```
rosparam set use_sim_time true
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
roscd hdl_localization/rviz
rviz -d hdl_localization.rviz
```

Now, you could enjoy hdl_localization package! :smile:


## Acknowldegement

Thanks to [koide3](https://github.com/koide3) for releasing the hdl_localization ros package.  
This repository follows the license of [hdl_localization](https://github.com/koide3/hdl_localization).  
