#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="caveexpress"
rp_module_desc="Cave Express - Physics-Based 2D Platformer"
rp_module_menus="4+"
rp_module_flags="!x86 !mail"

function depends_caveexpress() {
    getDepends cmake libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-net-dev libbox2d-dev libyajl-dev libglm-dev libgtest-dev libsqlite3-dev liblua5.2-dev zlib1g-dev binutils-dev libncurses5-dev git
}

function sources_caveexpress() {
    gitPullOrClone "$md_build" http://github.com/mgerhardy/caveexpress.git
}

function build_caveexpress() {
    mkdir "$md_build/build"
    cd "$md_build/build"
    cmake -DCMAKE_INSTALL_PREFIX="$md_inst" ..
    make
}

function install_caveexpress() {
    cd "$md_build/build"
    make install
}

function configure_caveexpress() {
    mkRomDir "ports"
    moveConfigDir "$home/.caveexpress" "$configdir/caveexpress"
    addPort "$md_id" "caveexpress" "Cave Express - Physics-Based 2D Platformer" "$md_inst/games/caveexpress"
}
