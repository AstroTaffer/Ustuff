#!/bin/sh

reflector --latest 20 --sort rate --save /etc/pacman.d/mirrorlist
