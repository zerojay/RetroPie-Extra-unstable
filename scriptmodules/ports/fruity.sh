#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="fruity"
rp_module_desc="Fruity"
rp_module_section="exp"
rp_module_flags="!mali"

function depends_fruity() {
    getDepends libsdl-mixer1.2
}

function install_fruity() {
    wget http://www.retroguru.com/fruity/fruity-v.latest-raspberrypi.zip -O "$md_inst/fruity.zip"
    unzip -n "$md_inst/fruity.zip" -d "$md_inst"
    rm "$md_inst/fruity.zip"
    mkdir "$home/.fruity"
    chown -R pi:pi "$home/.fruity"
    cd "$md_inst"
    ln -s "$home/.fruity/fruity.cfg" "fruity.cfg"
    ln -s "$home/.fruity/hiscores.dat" "hiscores.dat"
    ln -s "$home/.fruity/savegame.dat" "savegame.dat"
    chown -R pi:pi "$md_inst/"
}

function configure_fruity() {
    addPort "$md_id" "fruity" "Fruity" "pushd $md_inst; $md_inst/fruity_rpi; popd"

    chmod +x "$md_inst/fruity_rpi"
}

