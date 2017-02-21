############################################################################## NIX OS 
##############################################################################
{ config, pkgs, ... }:
{
 imports = [./hardware-configuration.nix];
 ####################################################################################################################################################################
 # Packages
 nixpkgs.config.allowUnfree = true;
 environment.systemPackages = with pkgs; [
# Apperence
gnome3.adwaita-icon-theme
gnome3.gnome_themes_standard
gtk_engines
gtk-engine-murrine
haskellPackages.xmobar
haskellPackages.xmonad
tango-icon-theme
rofi
trayer
xorg.xrandr
xscreensaver

# Software
gparted
htop
libreoffice
lxappearance
neovim
openvpn
roxterm
screenfetch
seafile-client
shutter
thunderbird
xfe
zathura  # PDF Viewer

# System
arandr
bashmount
busybox
curl
davfs2
exfat
ghc     
git
jdk
shared_mime_info
networkmanagerapplet
ntfs3g
pciutils     
#python27Packages.pip
python
python27Packages.pip
python27Packages.setuptools
python3
python35Packages.pip
python35Packages.setuptools
unrar
unzip
xbrightness
xorg.libXt
xorg.libXtst

# Writing
aspell
aspellDicts.de
aspellDicts.en
# texlive.combined.scheme-full
];

      
 ####################################################################################################################################################################
 # Services

 services.xserver = {
         # Graphic
	 # videoDrivers = [ "nouveau" ];
         
	 # keyboard
         enable = true;
         layout = "us";
	 xkbOptions = "eurosign:e";
  	 
         # Notebook
	 synaptics.enable = true;
	 synaptics.twoFingerScroll = true;

         # UI         
	 windowManager.xmonad.enable = true;
         windowManager.default = "xmonad";
         windowManager.xmonad.enableContribAndExtras = true;
         desktopManager.xterm.enable = false;
         displayManager.auto.enable = true;
         displayManager.auto.user = "user";
 };

 services.openssh.forwardX11 = true;
 #services.teamviewer.enable  = true;
 
 ####################################################################################################################################################################
 # Gerneral config
  
 	 # Time
  	 time.timeZone = "Europe/Berlin";
  	 
	 # Mount
	 fileSystems."/oyra" = 
	 {
	 device = "https://cloud.oyra.eu/seafdav";
   	 options = ["noauto,users,rw"];
	 fsType = "davfs";
	 };
	 security.sudo.extraConfig =
	 ''
  	 user ALL=(ALL) NOPASSWD: /home/user/.dotfiles/script/webdav.sh
  	 user ALL=(ALL) NOPASSWD: /home/user/.dotfiles/script/brightness_inc.sh
  	 user ALL=(ALL) NOPASSWD: /home/user/.dotfiles/script/brightness_dec.sh
	 '';

	 # Redshift
	 services.redshift = {
	     enable = true;
	     latitude = "50";
	     longitude = "10";
	 };

	 # Network
   	 networking.networkmanager.enable = true;
   	 
	 # Hardware
	 hardware = {
	     bumblebee = {
	     	enable = true;
	        connectDisplay = true;
	     };

	     pulseaudio = {
   	 	enable = true;
		support32Bit = true;
	     };

	     opengl.driSupport32Bit = true; 
	 };
	 
	 # Printer
  	 services.printing = {
   	     enable = true;
  	 };
         
         # ZSH
         programs.zsh.enable = true;
         users.defaultUserShell = "/run/current-system/sw/bin/zsh";
 
         # SSH
         services.openssh.enable = true;

	 # SWAP
	 swapDevices = [{
	 device = "/var/cache/swap/swap0";
	 }];
	 #swapDevices.*.size = "1024";

	 # Clean up
	 nix.gc.automatic = true;
	 nix.gc.dates = "03:14";
	 nix.gc.options = "--delete-older-than 30d";
	 nix.extraOptions = 
	 ''
	 gc-keep-output = true
	 gc-keep-derivations = true
	 auto-optimise-stor = true
	 '';

 ####################################################################################################################################################################
 # Users
 
 # user
 users.extraUsers.user = {
         isNormalUser = true;
         home = "/home/user";
         extraGroups = ["davfs2""wheel" "networkmanager" "libvirt" "libvirtd" "vboxusers"];
 };
 
 ####################################################################################################################################################################
 # Version
 system.stateVersion = "16.09";
 
 ####################################################################################################################################################################
 # Bootloader
 boot.loader.systemd-boot.enable = true;
 boot.loader.efi.canTouchEfiVariables = true;
 
####################################################################################################################################################################
 # Virtualisation
 #virtualisation.libvirtd.enable = true;
 #virtualisation.libvirtd.enableKVM = true;
 boot.kernelModules = [ "kvm-intel" "tun" "virtio" ];
 virtualisation.virtualbox.host.enable = true;
 }
