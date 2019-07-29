#!/bin/bash
sudo cp -rf ./* /usr/share/fonts/deepin-font-install/

sudo mkfontscale
sudo mkfontdir
sudo fc-cache -fv

