pkg update -y
pkg upgrade -y
pkg install openssh -y
echo "set ssh password /n"
passwd
echo "ssh installed and setup"
pkg install x11-repo -y
pkg install tigervnc -y
pkg install xfce4 -y
pkg install netsurf -y
pkg install firefox -y
pkg install xfce4-terminal -y
vncserver :1
touch .vnc/xstartup
echo "xfce4-session &" > .vnc/xstartup
export DISPLAY=":1"