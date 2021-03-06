#!/bin/bash

cd $HOME
xterm -hold -e "rosrun rosserial_python serial_node.py /dev/ttyACM0" &
xterm -hold -e "roslaunch usb_cam usb_cam-test.launch" &
xterm -hold -e "roslaunch ur_modern_driver ur10_bringup.launch robot_ip:=192.168.1.10 [reverse_port:=REVERSE_PORT]" &
sleep 4
roslaunch ur10_moveit_config ur10_moveit_planning_execution.launch limited:=true &
ROS_NAMESPACE=usb_cam rosrun image_proc image_proc &
sleep 4
roslaunch ur10_moveit_config moveit_rviz.launch config:=true &
sleep 4
rosrun a4_paper_turning soft_gripper_frame.py &
roslaunch apriltags_ros example.launch &

exit 0
