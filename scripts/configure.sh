#!/bin/zsh

if [ $# -eq 0 ]; then
    printf "Would you like to configure time zone? [Y/n] "; read opt
    if [[ $opt = "" ]] || [[ $opt = "y" ]] || [[ $opt = "Y" ]]; then
        configure-tz
    fi

    printf "Would you like to configure git? [Y/n] "; read opt
    if [[ $opt = "" ]] || [[ $opt = "y" ]] || [[ $opt = "Y" ]]; then
        configure-git
    fi

    printf "Would you like to configure an ssh key? [Y/n] "; read opt
    if [[ $opt = "" ]] || [[ $opt = "y" ]] || [[ $opt = "Y" ]]; then
        configure-ssh
    fi

    printf "Would you like to configure proxy? [Y/n] "; read opt
    if [[ $opt = "" ]] || [[ $opt = "y" ]] || [[ $opt = "Y" ]]; then
        configure-proxy
    fi

    printf "Would you like to configure a key for alpha vantage? [Y/n] "; read opt
    if [[ $opt = "" ]] || [[ $opt = "y" ]] || [[ $opt = "Y" ]]; then
        configure-alpha-vantage
    fi

    printf "Would you like to configure a key for enigma? [Y/n] "; read opt
    if [[ $opt = "" ]] || [[ $opt = "y" ]] || [[ $opt = "Y" ]]; then
        configure-enigma
    fi

    printf "Would you like to configure a key for iex? [Y/n] "; read opt
    if [[ $opt = "" ]] || [[ $opt = "y" ]] || [[ $opt = "Y" ]]; then
        configure-iex
    fi

    printf "Would you like to configure a key for tiingo? [Y/n] "; read opt
    if [[ $opt = "" ]] || [[ $opt = "y" ]] || [[ $opt = "Y" ]]; then
        configure-tiingo
    fi
else
    for arg in "$@"; do
        eval "configure-$arg"
    done
fi

exec zsh
