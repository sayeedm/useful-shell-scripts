#!/bin/bash



#check if ANDROID_SDK_HOME is exported
if env | grep -q ^ANDROID_SDK_HOME=
then
    #check command line arguments	
    if [ $# -ge 1 ]
    then
        device_index=0
        
        if [ $# -eq 2 ] 
        then
            device_index=$2
        fi
            
	output_of_adb_devices=`$ANDROID_SDK_HOME/platform-tools/adb devices | awk 'NR>1 {print $1}'`
        devices=($output_of_adb_devices)
	
        $ANDROID_SDK_HOME/platform-tools/adb -s ${devices[$device_index]} shell screencap -p | sed 's/\r$//' > $1 
    else
        echo "usage adb-screenshot <outputfile> <device-index> device index is the order in which they appears in adb devices command starting with 0, by default device index is 0"
    fi	
else
  echo "please set ANDROID_SDK_HOME"
  exit
fi
