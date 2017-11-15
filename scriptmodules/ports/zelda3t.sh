#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="zelda3t"
rp_module_desc="zelda3t - Zelda fangame"
rp_module_licence="Unknown"
rp_module_help=""
rp_module_section="exp"
rp_module_flags="!mali !x86"

function depends_zelda3t() {
    getDepends libsdl1.2-dev libsdl-gfx1.2-dev libsdl-mixer1.2-dev libsdl-image1.2-dev
}

function sources_zelda3t() {
    gitPullOrClone "$md_build" https://github.com/gameblabla/zelda-3t.git
}

function build_zelda3t() {
    make
    md_ret_require="$md_build/Zelda-3T"
}

function install_zelda3t() {
    md_ret_files=(
        'data'
        'Zelda-3T'
    )
}

function configure_zelda3t() {
    mkRomDir "ports"
    chmod -R 777 "$md_inst/data"
    moveConfigDir "$home/.config/zelda-3t" "$md_conf_root/$md_id/config"
    addPort "$md_id" "zelda3t" "zelda3t - Zelda fangame" "pushd $md_inst; $md_inst/Zelda-3T; popd"
}
