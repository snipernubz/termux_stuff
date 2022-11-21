echo "downloading noVNC"
git clone https://github.com/novnc/noVNC
echo -e "downloaded noVNC"

cat <<EOF > startnovnc.sh
#!/bin/bash

# Start noVNC
litip=$(dialog --inputbox "Enter listen IP" 0 0 --output-fd 1)
litport=$(dialog --inputbox "Enter listen port (default 6080)" 0 0 "6080" --output-fd 1)
$HOME/noVNC/utils/./novnc_proxy --vnc localhost:5901 --listen $litip:$litport &
EOF

echo "made start file"
chmod +x startnovnc.sh
echo "
run ./startnovnc.sh
to start noVNC
"
