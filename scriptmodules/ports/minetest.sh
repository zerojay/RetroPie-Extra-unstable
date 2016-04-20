#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="minetest"
rp_module_desc="Minetest - Minecraft Clone"
rp_module_menus="4+"
rp_module_flags="!mali !x86"

function depends_minetest() {
    getDepends libirrlicht-dev cmake libbz2-dev libpng12-dev libjpeg-dev libxxf86vm-dev libgl1-mesa-dev libsqlite3-dev libogg-dev libvorbis-dev libopenal-dev libcurl4-gnutls-dev libfreetype6-dev zlib1g-dev libgmp-dev libjsoncpp-dev xinit xorg matchbox
}

function sources_minetest() {
    gitPullOrClone "$md_build" https://github.com/minetest/minetest.git
    gitPullOrClone "$md_build/games/minetest_game" https://github.com/minetest/minetest_game.git
}

function build_minetest() {
    cmake . -DRUN_IN_PLACE=FALSE -DBUILD_SERVER=TRUE -DBUILD_CLIENT=TRUE -DCMAKE_BUILD_TYPE=Release -DENABLE_GLES=TRUE -DENABLE_CURL=TRUE -DCMAKE_INSTALL_PREFIX="$md_inst"
    make
}

function install_minetest() {
    make install
}

function configure_minetest() {
    moveConfigDir "$home/.minetest" "$md_conf_root/$md_id"
    addPort "$md_id" "minetest" "Minetest - Minecraft Clone" "xinit $md_inst/Minetest.sh"

    cat >"$md_inst/Minetest.sh" << _EOF_
#!/bin/bash
xset -dpms s off s noblank
matchbox-window-manager -use_titlebar no &
$md_inst/bin/minetest
_EOF_
    chmod +x "$md_inst/Minetest.sh"


}
