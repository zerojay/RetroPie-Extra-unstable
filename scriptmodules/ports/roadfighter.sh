#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="roadfighter"
rp_module_desc="Roadfighter - Retro Remake"
rp_module_section="exp"
rp_module_flags="!x86 !mali"

function depends_roadfighter() {
    getDepends libsdl1.2-dev libsdl-mixer1.2-dev libsdl-image1.2-dev libsdl-net1.2-dev libsdl-ttf2.0-dev
}

function sources_roadfighter() {
    gitPullOrClone "$md_build" https://github.com/ptitSeb/roadfighter.git
    sed -i "s/-mcpu=cortex-a8 -mfpu=neon -mfloat-abi=softfp -ftree-vectorize -fsingle-precision-constant -g -Ofast/-mfloat-abi=hard -g3 -O3/" "$md_build/Makefile"
}

function build_roadfighter() {
    make
    md_ret_require="$md_build/roadfighter"
}

function install_roadfighter() {
    md_ret_files=(
       'roadfighter'
       'sound'
       'maps'
       'graphics'
       'fonts'
       'readme.txt'
    )
}

function configure_roadfighter() {
    mkRomDir "ports"
    moveConfigDir "$home/.roadfighter" "$md_conf_root/$md_id"
    addPort "$md_id" "roadfighter" "Roadfighter - Retro Remake" "pushd $md_inst; ./roadfighter; popd" 
}
