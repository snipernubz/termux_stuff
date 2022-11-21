# sets up a icecast server, though server options need to be optimized

pkg update
echo "installing pulseaudio ffmpeg and icecast"

pkg install pulseaudio ffmpeg icecast 
echo -e "adding commands to default pulseaudio config"

sinkname=$(dialog --inputbox "Name for icecast sink, defaults to 'ice'" 0 0 'ice' --output-fd 1)
sinkdesc=$(dialog --inputbox "Description for icecast sink, defaults to 'ice_desc'" 0 0 'ice_desc' --output-fd 1)

echo "

# icecast sink
load-module module-null-sink sink_name=$sinkname rate=44100 sink_properties=device.description=$sink_desc

" >> $PREFIX/etc/pulse/default.pa
echo -e "settings appended to default.pa"

srcpass=$(dialog --inputbox "Set password for icecast sources defaults to 'spog'" 0 0 'spog' --output-fd 1)

sed 's/hackme/$srcpass/1' $PREFIX/etc/icecast.xml

echo -e "set icecast source password"
echo -e "makeing log directory for icecast"

mkdir $PREFIX/var/log/icecast

echo -e "makeing startup script"

touch pa_to_ice.sh
cat << EOF > pa_to_ice.sh
#!/bin/bash

echo -e "starting pulseaudio"
pulseaudio --start

echo "started pulseaudio"

echo -e "starting icecast"

icecast -c $PREFIX/etc/icecast.xml

echo -e "starting stream"

parec -d $sinkname.monitor --format s16le | ffmpeg -f s16le -i pipe:0 -acodec libmp3lame -ab 705k -ac 1 -content_type audio/mpeg -f mp3 icecast://source:$srcpass@127.0.0.1:8000/termux &

echo "
stream started
connect to it at 
http://127.0.0.1:8000/termux
audio sent to the '$sinkname' will be streamed
NOTE: AUDIO WILL SOUND DISTORTED
"
EOF

chmod +x pa_to_ice.sh
echo "startup file made"
echo "all done, Enjoy!"
