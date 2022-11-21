# sets up a icecast server, though server options need to be optimized

pkg update
echo "installing pulseaudio ffmpeg and icecast"
pkg install pulseaudio ffmpeg icecast 

echo "
# icecast settings

# null sinks
load-module module-null-sink sink_name=pogs rate=44100 sink_properties=device.description=pog
load-module module-null-sink sink_name=poggers sink_properties=device.description=pogger rate=44100

# loopback
load-module module-loopback source=pogs.monitor sink=OpenSL_ES_sink
" >> $PREFIX/etc/pulse/default.pa

# <source-password>hackme</source-password> for icecast
