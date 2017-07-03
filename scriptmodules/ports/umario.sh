#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="umario"
rp_module_desc="uMario - Super Mario Bros. Remake"
rp_module_licence="GPL2 https://raw.githubusercontent.com/jakowskidev/uMario_Jakowski/master/LICENSE"
rp_module_section="exp"

function depends_umario() {
    getDepends cmake libsdl2-2.0-0 libsdl2-image-2.0-0 libsdl2-mixer-2.0-0 libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev 
}

function sources_umario() {
    gitPullOrClone "$md_build" https://github.com/jakowskidev/uMario_Jakowski.git
}


function build_umario() {
    mkdir build && cd build
    cmake ..
    make
    md_ret_require="$md_build/build/uMario"
}

function install_umario() {
    md_ret_files=(
        'build/uMario'
    )
}

function configure_umario() {
    setConfigRoot "ports"

    addPort "$md_id" "umario" "uMario - Super Mario Bros Remake" "$md_inst/uMario"
}
