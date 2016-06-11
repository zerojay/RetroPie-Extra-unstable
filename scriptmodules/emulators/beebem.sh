#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="beebem"
rp_module_desc="beebem - BBC Micro Emulator"
rp_module_section="exp"
rp_module_flags="!x86 !mali"

function depends_beebem() {
    getDepends libgtk2.0-dev libsdl1.2-dev automake
}

function sources_beebem() {
    gitPullOrClone "$md_build" https://github.com/zerojay/beebem.git
}

function build_beebem() {
    autoreconf -fi
    ./configure --prefix="$md_inst"
    make
    md_ret_require="$md_build/src/beebem"
}

function install_beebem() {
    mkdir "$md_inst/share"
    mkdir "$md_inst/share/$md_id"
    cp -Rv "$md_build/"{README,COPYING} "$md_inst/"
    cp -Rv "$md_build/src/beebem" "$md_inst/"
    cp -Rv "$md_build/data/"{config,phroms,resources,roms,state,media} "$md_inst/share/$md_id"
}

function configure_beebem() {
    mkRomDir "bbcmicro"
    moveConfigDir "$home/.beebem" "$md_conf_root/$md_id/"
    addSystem 0 "$md_id" "bbcmicro" "xinit $md_inst/beebem %ROM%"
}
