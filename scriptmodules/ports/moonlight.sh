#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="moonlight"
rp_module_desc="moonlight - Open Source nVidia GameStream"
rp_module_licence="GPL3 https://raw.githubusercontent.com/irtimmer/moonlight-embedded/master/LICENSE"
rp_module_section="exp"
rp_module_flags="!mali !x86"

function depends_moonlight() {
    if [[ "$__raspbian_ver" -lt 8 ]]; then
        echo "deb http://archive.itimmer.nl/raspbian/moonlight wheezy main" >> /etc/apt/sources.list
    else
        echo "deb http://archive.itimmer.nl/raspbian/moonlight jessie main" >> /etc/apt/sources.list
    fi
    apt-get update
}

function install_bin_moonlight() {
    aptInstall moonlight-embedded
}

function configure_moonlight() {
    mkRomDir "ports"
    moveConfigDir "$home/.moonlight" "$configdir/moonlight"
    addPort "$md_id" "moonlight" "moonlight - Open Source nVidia GameStream (720p 30fps)" "$md_inst/moonlight stream 192.168.0.101 -720 -30fps -mapping $configdir/$md_id/controllername.map"
    addPort "$md_id" "moonlight" "moonlight - Open Source nVidia GameStream (720p 60fps)" "$md_inst/moonlight stream 192.168.0.101 -720 -60fps -mapping $configdir/$md_id/controllername.map"
    addPort "$md_id" "moonlight" "moonlight - Open Source nVidia GameStream (1080p 30fps)" "$md_inst/moonlight stream 192.168.0.101 -1080 -30fps -mapping $configdir/$md_id/controllername.map"
    rp_module_help="To complete moonlight setup, you will need to manually pair moonlight to your PC (moonlight pair [ip address]) and then set up a controller mapping (moonlight map $configdir/$md_id/controllername.map). You will then need to edit $configdir/$md_id/emulators.cfg to match the ip address and controller mapping file name."
}
