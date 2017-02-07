#!/bin/sh
#Ascii Standard
cat <<"EOF"

---------------------------------------------------------------------------------
  ___           _        _ _ _               ____        _    __ _ _
 |_ _|_ __  ___| |_ __ _| | (_)_ __   __ _  |  _ \  ___ | |_ / _(_) | ___  ___
  | || '_ \/ __| __/ _` | | | | '_ \ / _` | | | | |/ _ \| __| |_| | |/ _ \/ __|
  | || | | \__ \ || (_| | | | | | | | (_| | | |_| | (_) | |_|  _| | |  __/\__ \
 |___|_| |_|___/\__\__,_|_|_|_|_| |_|\__, | |____/ \___/ \__|_| |_|_|\___||___/
                                     |___/
---------------------------------------------------------------------------------
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
                    ln $HOME/.dotfiles/nixos/p50/configuration.nix /etc/nixos/configuration.nix
                    mkdir $HOME/.nixpkgs
                    ln $HOME/.dotfiles/nixos/p50/config.nix $HOME/.nixpkgs/config.nix
                    echo "---------------------------"
                    echo "---------------------------"
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
        mkdir $HOME/.xmonad
        ln $HOME/.dotfiles/xmonad/xmonad.hs $HOME/.xmonad/xmonad.hs

        PS3='Please select for which Device you want to install Xmobar: '
        options=("P50" "Quit")
        select opt in "${options[@]}"
        do
            case $opt in
                "P50")
                    echo "Installing Dotfiels for P50"
                    echo "------------ Spacemacs ---------------"
                    perl -p -i.bak -e "~s|/home/user|"$HOME"|" $HOME/.dotfiles/xmonad/P50_xmobarrc
                    ln $HOME/.dotfiles/xmonad/P50_xmobarrc $HOME/.xmonad/xmobarrc
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
        ln $HOME/.dotfiles/.spacemacs ~/.spacemacs
        echo -e
        ;;
    n|N)
        echo -e
        echo "no"
        echo -e
        ;;
  *) echo invalid option ;;
esac
