#!/bin/sh
dateTime(){
  OUTFILE="OUTFILE.txt"     #To store the file that will contain the output
  cat /dev/null > $OUTFILE        #To clear the file
  HOLDFILE="HOLDFILE.txt"    #To store the file that will contain the holded data
  cat /dev/null > $HOLDFILE         #To clear the file
  DATESTAMP=`date +"%h %d %Y at %T"`   #variable store date
  echo "Date/Time of Search: "$DATESTAMP"" >> $OUTFILE        #To save the date and time of operation to outfile
}

findFiles(){
  echo "Searching for Files Larger Than 8 Mb starting in $HOME"     #just a message
  echo "Please Standby for the Search Results..."
  find ~ -size +8M >> $HOLDFILE        #To save the files that has size larger than 8 MB in holdfile
  FILESIZE=$(stat -c%s "$HOLDFILE")           #Variable to get the size of holdfile
  if [ "$FILESIZE" -eq "0" ]            #To check that if it's empty or no
  then
    echo "No files were found that are larger than 8 MB"
    echo "Exiting..."
    exit
  fi

#if the holdfile is not empty so:
  NUMOFFILES=`wc -l < $HOLDFILE`    #get the number of lines in the holdfile that represent number of files
  echo $NUMOFFILES >> $OUTFILE    #Write the number of file to the outfile
  echo "Number of files found: $NUMOFFILES"     #display the number of files found
  cat $HOLDFILE >> $OUTFILE         #To write the data of holdfile to outfile

}

printOutput(){
    cat $OUTFILE          #To read the outfile
    echo "These search results are stored in `readlink -f $OUTFILE`"  #To get the file path
    echo "Search complete...Exiting..."
}

dateTime
findFiles
printOutput
