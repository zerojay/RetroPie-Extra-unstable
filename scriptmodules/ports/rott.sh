#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="rott"
rp_module_desc="rott - Rise of the Triad port"
rp_module_menus="4+"
rp_module_flags="!mali !x86"

function depends_rott() {
    getDepends libsdl1.2-dev libsdl-mixer1.2-dev automake unzip
}

function sources_rott() {
    gitPullOrClone "$md_build" https://github.com/JohnnyonFlame/RoTT.git
}

function build_rott() {
    make clean
    make
    md_ret_require=(
        "$md_build/rott-huntbgin"
        "$md_build/rott-darkwar"
        "$md_build/rott-rottcd"
        "$md_build/rott-rottsite"
    )
}

function install_rott() {
    md_ret_files=(
	"rott-huntbgin"
        "rott-darkwar"
        "rott-rottcd"
        "rott-rottsite"
    )
}

function configure_rott() {
    mkRomDir "ports"
    mkRomDir "ports/$md_id"
    mkRomDir "ports/$md_id/standard"
    mkRomDir "ports/$md_id/shareware"
    
    wget "http://icculus.org/rott/share/1rott13.zip" -O 1rott13.zip
    unzip -L -o 1rott13.zip rottsw13.shr
    unzip -L -o rottsw13.shr -d "$md_inst/shareware" huntbgin.wad huntbgin.rtc huntbgin.rtl remote1.rts
    
    moveConfigDir "$home/.rott" "$md_conf_root/rott"

    addPort "$md_id" "rott" "rott - Rise of the Triad port" "$md_inst/bin/rott"
    addPort "$md_id" "rott-shareware" "rott - Rise of the Triad port Shareware" "$md_inst/bin/rott-shareware"
    __INFMSGS+=("Please add your full version ROTT files to $romdir/ports/$md_id/ to play.")
}
