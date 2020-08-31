# Audio-switcher
Switches between sinks automatically when hearphones are plugged/unplugged. Designed to work with Pulseaudio running over Alsa (Kubuntu)

Run the included bash file in the background
The script here handles moving between two ports hence code to switch audio-streams is also inlcuded, it is uneeded when switching between sink ports

To check your avaiable sinks and ports run "pacmd list-sinks"
Make changes to sink numbers and ports as needed according to your configuration

I run it as a service thus it always running since startup, the basic makeup is also provided, make changes if you also intend to run it as such

[I will make it installable and upload the related file in a few days as soon as I can get the time]
