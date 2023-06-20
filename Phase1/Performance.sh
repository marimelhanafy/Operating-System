#!/bin/sh

diskUsage(){    #First subroutine
  du -h ~ > tmp.txt    #To get the disk usage of home and save it to file
  sort -r -o Disk_Usage.txt tmp.txt  #To sort by reversing the disk usage of home and save it to file
  rm tmp.txt
  dmesg > memo-HDMessage_Log.txt   #To get the kernal output and save it to file
  lscpu > cpu_inf.txt       #To get the CPU information and save it to file
  wc -w memo-HDMessage_Log.txt > Message_Count.txt   #To get the word count of kernal output and save it to file
  tar -cvf Phase1.tar.gz Disk_Usage.txt cpu_inf.txt Message_Count.txt  #To create compressed folder with the 4 files
  time=`date +"%H%M%S"`   #To get the current time
  mkdir "$time"           #Create directory and name it with the current time
  mv Phase1.tar.gz "$time"  #To move the compressed file to the created directory
}

permissions(){    #Second subroutine
  dirName=`date +"%y%m%d%H%M%S"`    #To get current date and Time
  mkdir ~/"$dirName"    #Create directory with current date and Time
  for file in ~/*; do   #for loop to trace the home directory
    if [ -w $file  ]; then      #Checkes if file has write permission
      if [ -r $file  ]; then
        cp $file ~/"$dirName"       #Copy that file to the created directory
        chmod u=r ~/"$dirName"$file    #To set the copied file to be read only
      fi     #end of if statment
    fi
  done    #end of for statment
}

CountEnd(){     #Third subroutine
  echo "Number of files that has read: "
  ls ~/"$dirName" | wc -l       #To get the number of files that has read permission
  echo "The backup is completed..."     #End of backup message
  echo "---------------------------------------------------------------------------"
}


diskUsage     #To call the first subroutine
permissions   #To call the second subroutine
CountEnd      #To call the third subroutine
