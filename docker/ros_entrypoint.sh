#!/bin/bash
 
set -e

# Ros build
source "/opt/ros/melodic/setup.bash"


# Libray install if you want

echo "================Docker Env Ready================"

cd /root/catkin_ws

exec "$@"
