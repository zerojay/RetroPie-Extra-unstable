#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="abuse"
rp_module_desc="Abuse"
rp_module_menus="4+"
rp_module_flags="nobin !mali !x86"

function depends_abuse() {
    getDepends xorg
}

function install_abuse() {
    
    aptInstall abuse abuse-sfx
}

function configure_abuse() {
    mkRomDir "ports"
    moveConfigDir "$home/.abuse" "$md_conf_root/abuse"
    addPort "$md_id" "abuse" "Abuse" "xinit abuse"
}
