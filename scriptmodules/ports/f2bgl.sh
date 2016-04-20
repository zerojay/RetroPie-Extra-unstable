#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="f2bgl"
rp_module_desc="f2bgl - Fade To Black Engine"
rp_module_menus="4+"
rp_module_flags="!mali !x86"

function depends_f2bgl() {
    getDepends libsdl2-dev
}

function sources_f2bgl() {
    wget -O- -q http://cyxdown.free.fr/f2b/f2bgl-0.1.8.tar.bz2 | tar -xvj --strip-components=1
}

function build_f2bgl() {
    make
}

function install_f2bgl() {
    md_ret_files=('f2bgl')
}

function configure_f2bgl() {
    mkRomDir "ports"
    mkRomDir "ports/$md_id"

    addPort "$md_id" "f2bgl" "f2bgl - Fade To Black Engine" "$md_inst/f2bgl --datapath=$romdir/ports/$md_id"
    __INFMSGS+=("Please copy your Fade To Black data files to $romdir/ports/$md_id before running f2bgl.")
}
