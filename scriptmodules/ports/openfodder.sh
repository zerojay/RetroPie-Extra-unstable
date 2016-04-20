#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="openfodder"
rp_module_desc="openfodder - Cannon Fodder Engine"
rp_module_menus="4+"
rp_module_flags="!x86 !mali"

function depends_openfodder() {
    getDepends build-essential libsdl2-dev libsdl2-mixer-dev clang 
}

function sources_openfodder() {
    gitPullOrClone "$md_build" https://github.com/segrax/openfodder.git
}

function build_openfodder() {
    make
    md_ret_require="$md_build"
}

function install_openfodder() {
    md_ret_files=(
        'Run/OpenFodder'
        'Run/Data'
        'Run/Saves'
    )
}

function configure_openfodder() {
    mkRomDir "ports"
    mkRomDir "ports/$md_id"
    mkUserDir "$configdir/$md_id"

    ln -s "$md_inst/Data" "$romdir/ports/openfodder/"
    moveConfigDir "$md_inst/Saves"  "$configdir/$md_id"

    chown -R $user:$user "$romdir/ports/$md_id"

    addPort "$md_id" "openfodder" "openfodder - Cannon Fodder Engine" "pushd $md_inst; $md_inst/OpenFodder; popd"
}
