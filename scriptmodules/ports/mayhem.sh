#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="mayhem"
rp_module_desc="Mayhem - Remake of Amiga Game"
rp_module_licence="BSD3 https://raw.githubusercontent.com/martinohanlon/mayhem-pi/master/LICENSE"
rp_module_section="exp"
rp_module_flags="!x86 !mali"

function depends_mayhem() {
    getDepends liballegro5.2 liballegro5-dev liballegro-audio5-dev liballegro-acodec5-dev liballegro-image5-dev liballegro-ttf5-dev libdumb1 pulseaudio xinit
}

function sources_mayhem() {
    gitPullOrClone "$md_build" https://github.com/martinohanlon/mayhem-pi.git
}

function build_mayhem() {
  make clean
  make
  md_ret_require="$md_build/mayhem2-pi"
}

function install_mayhem() {
    md_ret_files=(
	'mayhem2-pi'
	'assets'
        'mayhem2.jpg'
        'start.sh'
    )
}

function configure_mayhem() {
    mkRomDir "ports"
    addPort "$md_id" "mayhem" "Mayhem - Remake of Amiga Game" "pushd $md_inst; ./start.sh; popd"
}
