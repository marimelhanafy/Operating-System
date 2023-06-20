#!/bin/sh

display() {   #first subroutine
  #Display a message only
  echo "*****************************************************************************"
  echo "`whoami` is currently logged in the linux system"
  echo "The current month calender    `cal`"
  echo "The time on the linux system is `date`"
  idle=`who -u | awk '{print $6 $7}'`
  echo "`who -b` and system idle $idle"
  echo "The current directory working path is "`pwd`
  echo "The current shell is $SHELL"
  size=$(du -sh | awk '{print $1}')
  echo "My home directory is $HOME with the directory size in my home = $size"
  echo "USAGE: This script will run infinitely and check the system time till it reaches the time of 11:59 PM then it will start doing some backups and system checks"
  echo "*****************************************************************************"
  echo "Waitng for results..."
}

run() {     #second subroutine
  time="2359"     #Time setted to 11:59 PM
  time2="0009"    #Time setted to 12:09 AM
  while :; do     #Infinite loop to keep the program running
    currenttime=`date +"%H%M"`      #Getting the current time
    if [ "$currenttime" -eq "$time" ]; then   #Checking if current time is 12 AM or no
      sh Connectivity.sh     #Calling the Connectivity script
      sh ControlTraffic.sh    #Calling the ControlTraffic script
      sleep 60            #Sleeping for 1 min to force the execution to be 1 time in this min 12:00
    fi      #Close if statment
    if [ "$currenttime" -eq "$time" ]; then   #Checking if current time is 12 AM or no
      sh Performance.sh     #Calling the performance script
      sh FileSystem.sh     #Calling the FileSystem script
      sleep 60            #Sleeping for 1 min to force the execution to be 1 time in this min 12:00
    fi      #Close if statment
  done      #End of while loop
}

display     #To call the first subroutine
run         #To call the second subroutine
trap "`sh Trap.sh`" SIGINT SIGTERM
