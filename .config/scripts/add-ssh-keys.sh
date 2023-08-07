#! /usr/bin/env bash

# If ~/.ssh doesn't exist, there is nothing to do
[[ ! -d "~/.ssh/" ]] || ( echo "Nothing to do" && exit 0 )

[[ -z "$SSH_AUTH_SOCK" ]] && echo "SSH agent not running" && exit 1
[[ -z "$SSH_ASKPASS" ]] && echo "SSH_ASKPASS is not set, cannot add keys" && exit 1


for _key in ~/.ssh/*.pub
do
    echo "Adding key ${_key%.pub}"
    ssh-add -q ${_key%.pub} >> /dev/null
done




