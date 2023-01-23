picom --daemon &
# feh --bg-scale /usr/share/background/purple_evening/girl-in-the-pool.png
feh --bg-scale Paintings/America/Edward\ Hopper/nighthawks_1942.jpg
setxkbmap us,ru -option "grp:win_space_toggle" &
sh .config/dwm-config/dwm_status.sh &

# RTags daemon
cd /home/floatfoo/rtags/
./bin/rdm &
./bin/rc -J .
cd 
# RTags end
emacs --fg-daemon &

xrdb -merge ~/.Xresources
eval $(dbus-launch --sh-syntax --exit-with-session dwm)

dwm
