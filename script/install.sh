#!/bin/sh
#Ascii Standard
RED='\033[0;31m'
NC='\033[0m' # No Color
cat <<"EOF"

---------------------------------------------------------------------------------
  ___           _        _ _ _               ____        _    __ _ _
 |_ _|_ __  ___| |_ __ _| | (_)_ __   __ _  |  _ \  ___ | |_ / _(_) | ___  ___
  | || '_ \/ __| __/ _` | | | | '_ \ / _` | | | | |/ _ \| __| |_| | |/ _ \/ __|
  | || | | \__ \ || (_| | | | | | | | (_| | | |_| | (_) | |_|  _| | |  __/\__ \
 |___|_| |_|___/\__\__,_|_|_|_|_| |_|\__, | |____/ \___/ \__|_| |_|_|\___||___/
                                     |___/
---------------------------------------------------------------------------------
EOF
echo -e "${RED}Attention:${NC} Input is not checked${RED}!!!${NC}"
echo "Example (/home/user)"
read -p "Enter the path to Home: " HOMEDIR
echo $HOMEDIR
cp .dotfiles/ $HOMEDIR/
cat <<"EOF"
--------------------------
  _   _ _
 | \ | (_)_  _____  ___
 |  \| | \ \/ / _ \/ __|
 | |\  | |>  < (_) \__ \
 |_| \_|_/_/\_\___/|___/
--------------------------
EOF
echo "If you do not want to copy the configuration.nix file or do not use Nixos select Quit."
PS3='Please select for which Device you want to install nixos: '
options=("P50" "Quit")
select opt in "${options[@]}"
do
    case $opt in
                "P50")
                    echo "Installing Dotfiels for P50"
                    echo "---------------------------"
                    echo "Link Nixos Dotfiles"
                    ln $HOMEDIR/.dotfiles/nixos/p50/configuration.nix /etc/nixos/configuration.nix
                    mkdir $HOMEDIR/.nixpkgs
                    ln $HOMEDIR/.dotfiles/nixos/p50/config.nix $HOMEDIR/.nixpkgs/config.nix
                    echo "---------------------------"
                    echo "---------------------------"
                    nixos-rebuild switch
                    break
                    ;;
                "Quit")
                    echo "Without configuration.nix"
                    break
                    ;;
        *) echo invalid option;;
    esac
done
cat <<"EOF"
------------------------------------------------
__  __                                _
\ \/ /_ __ ___   ___  _ __   __ _  __| |
 \  /| '_ ` _ \ / _ \| '_ \ / _` |/ _` |
 /  \| | | | | | (_) | | | | (_| | (_| |
/_/\_\_| |_| |_|\___/|_| |_|\__,_|\__,_|
------------------------------------------------
EOF

read -n1 -p "Install Xmonad Dotfiles [y,n]" doit
case $doit in
    y|Y)
        echo "Link Xmonad Dotfiles"
        mkdir $HOMEDIR/.xmonad
        ln $HOMEDIR/.dotfiles/xmonad/xmonad.hs $HOMEDIR/.xmonad/xmonad.hs

        PS3='Please select for which Device you want to install Xmobar: '
        options=("P50" "Quit")
        select opt in "${options[@]}"
        do
            case $opt in
                "P50")
                    echo "Installing Dotfiels for P50"
                    echo "------------ Spacemacs ---------------"
                    perl -p -i.bak -e "~s|/home/user|"$HOMEDIR"|" $HOMEDIR/.dotfiles/xmonad/P50_xmobarrc
                    ln $HOMEDIR/.dotfiles/xmonad/P50_xmobarrc $HOMEDIR/.xmonad/xmobarrc
                    break
                    ;;
                "Quit")
                    echo "Without Xmobar"
                    break
                    ;;
                *) echo invalid option;;
            esac
        done
        echo -e
        ;;
    n|N)
        echo -e
        echo "no"
        echo -e
        ;;
    *) echo invalid option ;;
esac
cat <<"EOF"
-------------------------------------------------------
 ____
/ ___| _ __   __ _  ___ ___ _ __ ___   __ _  ___ ___
\___ \| '_ \ / _` |/ __/ _ \ '_ ` _ \ / _` |/ __/ __|
 ___) | |_) | (_| | (_|  __/ | | | | | (_| | (__\__ \
|____/| .__/ \__,_|\___\___|_| |_| |_|\__,_|\___|___/
      |_|
-------------------------------------------------------
EOF
read -n1 -p "Install Spacemacs [y,n]" doit
case $doit in
    y|Y)
        echo "Installing Spacemacs"
        rm ~/.emacs
        git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
        echo "Link Spacemacs Configfile"
        ln $HOMEDIR/.dotfiles/.spacemacs ~/.spacemacs
        echo -e
        ;;
    n|N)
        echo -e
        echo "no"
        echo -e
        ;;
  *) echo invalid option ;;
esac
