#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

run picom --experimental-backends
run ksuperkey -e 'Super_L=Alt_L|F1'
run playerctld
run pasystray -m 100
run xmodmap -e 'keycode  48 = apostrophe quotedbl apostrophe quotedbl dead_acute dead_diaeresis'
