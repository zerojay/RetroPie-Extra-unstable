#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="rockbot"
rp_module_desc="rockbot - Mega Man clone"
rp_module_section="exp"
rp_module_flags="!x11 !mali"
rp_module_help="To stop the game from flickering like crazy, go into the Config menu, then PC and then set the game to fullscreen with any scaling type. Do not leave scaling set to NONE. Quit the game afterwards and restart it and everything should be fixed."

function depends_rockbot() {
    getDepends libsdl1.2-dev libsdl-gfx1.2-dev libsdl-mixer1.2-dev libsdl-ttf2.0-dev libsdl-image1.2-dev qt5-qmake
}

function sources_rockbot() {
    gitPullOrClone "$md_build" https://github.com/protoman/rockbot.git
}

function build_rockbot() {
    sed -i 's/CONFIG += playstation2/#CONFIG += playstation2/g' "$md_build/Rockbot.pro"
    sed -i 's/#CONFIG += raspberry/CONFIG += raspberry/g' "$md_build/Rockbot.pro"
    qmake
    make
    md_ret_require="$md_build/rockbot"
}

function install_rockbot() {
    md_ret_files=(
       'rockbot'
       'build/fonts'
       'build/games'
       'build/shared'
       'build/template'
       'build/strings_ingame.dat'
    )
}

function configure_rockbot() {
    mkRomDir "ports"
    moveConfigDir "$home/.rockbot" "$md_conf_root/$md_id"
    chown -R $user:$user "$md_inst"

    addPort "$md_id" "rockbot" "rockbot - Mega Man clone" "pushd $md_inst; $md_inst/rockbot; popd"
}
