#!/bin/bash

## Common
alias share-folder='docker run --rm -v $(pwd):/usr/local/apache2/htdocs/:ro -p 80 -d httpd'

alias ls='ls --color'
alias ll='ls -alh'

alias git='LANGUAGE=en_US.UTF-8 git'
alias gst='git status'
alias gl='git log --pretty=oneline'

alias mkm='make clean && make'

alias ip='ip -c'

alias c='xclip -selection c'
alias v='VIMFILES=$(fzf -e -m); [ ! -z "${VIMFILES}" ] && vim $VIMFILES || echo "No files provided"; unset VIMFILES'

alias mip='docker run --rm quay.io/fydrah/mip && echo'

alias minikube-start='minikube start --memory=4096 --kubernetes-version v1.18.0 --vm-driver kvm2 --extra-config=apiserver.authorization-mode=RBAC'

## Localbackup
function localbackup() {
  $(mountpoint /run/media/fhardy/localbackup 2>/dev/null >/dev/null)
  if [ "$?" -eq "0" ];
  then
    echo "Unmount and lock"
    udisksctl unmount -b /dev/disk/by-label/localbackup
    udisksctl lock -b /dev/mmcblk0
  else
    echo "Unlock and mount"
    udisksctl unlock -b /dev/mmcblk0 --key-file <(echo -n $(pass perso/localbackup))
    udisksctl mount -b /dev/disk/by-label/localbackup
  fi
}
