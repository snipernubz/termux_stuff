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

# <source-password>hackme</source-password> for icecast
