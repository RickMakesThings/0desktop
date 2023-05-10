#!/bin/bash

# Run updates
sudo dnf update -y && sudo dnf upgrade -y

# Add repos
sudo dnf -y install \https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf -y install \https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Install desktop environment software
sudo dnf -y install bspwm sxhkd picom lightdm lightdm-gtk rofi feh dunst pavucontrol alacritty nemo nemo-compare nemo-fileroller nemo-image-converter nano firefox xorg-x11-server-Xorg google-roboto-fonts google-roboto-mono-fonts baobab gnome-calendar gnome-clocks gnome-calculator gnome-system-monitor gnome-screenshot cava nm-connection-editor blueman ffmpeg-free ffmpegthumbnailer redshift timeshift protonvpn-cli playerctl kde-connect

# Extra software
#sudo dnf -y install lutris darktable gimp ardour6 krita scribus blender libreoffice-writer libreoffice-calc libreoffice-impress evolution obs-studio elementary-code xephyr vlc freecad inkscape icecat
# Flatpaks
#flatpak install org.freedesktop.Platform.openh264 no.mifi.losslesscut io.gitlab.librewolf-community com.visualstudio.code-oss org.signal.Signal com.valvesoftware.Steam com.valvesoftware.Steam.CompatibilityTool.Proton-GE com.github.tchx84.Flatseal

# Dependencies/packages for building
sudo dnf -y install gcc make pkg-config cairo-devel libxcb-devel libevdev-devel systemd-devel


# Create all necessary directories
mkdir -p ~/{.config/{0desktop,bspwm,sxhkd,picom,rofi,dunst,alacritty,cava,neofech,vlc,nemo,},.themes,.icons}/


# Download the custom 0desktop repo
#cd ~/.config/0desktop
#git clone [INSERT REPO LINK]


# Clone Elkowar's Wacky Widgets from GitHub
cd ~/.config
git clone https://github.com/elkowar/eww.git

# Build and install EWW
cd eww
make
sudo make install


# Clone logiops from GitHub
cd ~/.config
git clone https://github.com/PixlOne/logiops.git

# Build and install logiops
cd logiops
make
sudo make install


# Download & install themes and icons


# Copy config files to the proper locations
#bspwm
cp /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/
#sxhkd
cp /usr/share/doc/sxhkd/examples/sxhkdrc ~/.config/sxhkd/
#picom
cp /usr/share/doc/picom/examples/picom.sample.conf ~/.config/picom/picom.conf
#lightdm
sudo cp /usr/lib/systemd/system/lightdm.service /etc/systemd/system/
sudo systemctl enable lightdm.service
#rofi
cp /usr/share/doc/rofi/examples/config.rasi ~/.config/rofi/config.rasi
#logiops
sudo cp contrib/90-logiops.rules /etc/udev/rules.d/
sudo cp contrib/logid.cfg /etc/
#dunst
#alacritty
#firefox
#librewolf
#icecat
#cava


# Extra files
#.bashrc


# Clean up
sudo dnf -y remove gcc make pkg-config cairo-devel libxcb-devel libevdev-devel systemd-devel


