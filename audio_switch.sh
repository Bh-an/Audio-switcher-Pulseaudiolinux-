#!/bin/bash

# Switching to headphones on plug 
#
# Sinks may vary depending on your configuration 
# Run "pacmd list-sinks" to get sinks and related ports and make changes 
# appropriately to the functions
#
# In the case of same port switching the function for changing application 
# streams is unecessary

listen_func(){
acpi_listen > /tmp/audio_switch_log
}

set_to_headphones_func(){ # Set sink for headphone plug
pacmd set-default-sink 0
pacmd set-sink-port 0 analog-output-headphones
defaultsink=0
}

set_to_speakers_func(){ # Set sink for headphone unplug
pacmd set-default-sink 1
defaultsink=1
}

set_application_streams(){ # Moving all the sink inputs to the new sink
# $inputs: A list of currently playing inputs
inputs=0
inputs=$(pacmd list-sink-inputs | awk '$1 == "index:" {print $2}')
for application in $inputs
do 
  pacmd move-sink-input $application $defaultsink
done
}


main_func(){

while [ 1 ]
do

    status=$( tail -1 /tmp/audio_switch_log )

    if [ "$status" != "$oldstatus" ] 
    then 
    
             
        if [ "$status" == "jack/headphone HEADPHONE unplug" ]
        then
            
            set_to_speakers_func
            
        elif [ "$status" == "jack/headphone HEADPHONE plug" ]
        then 
            
            set_to_headphones_func
            
        fi
        
        set_application_streams
       
    fi
    
done
}
echo "garbagestring" > /tmp/audio_switch_log

oldstatus=$(echo "garbagestring")

listen_func &

main_func
