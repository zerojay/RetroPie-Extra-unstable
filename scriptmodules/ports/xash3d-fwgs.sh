#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="xash3d-fwgs"
rp_module_desc="xash3d-fwgs - Half-Life Engine Port"
rp_module_help="Please add your full version xash3d-fwgs files to $romdir/ports/$md_id/ to play."
rp_module_section="exp"
rp_module_flags="!mali !x86"

function depends_xash3d-fwgs() {
    getDepends libsdl2-dev libfontconfig1-dev libfreetype6-dev
}

function sources_xash3d-fwgs() {
    gitPullOrClone "$md_build" https://github.com/FWGS/xash3d-fwgs.git
}

function build_xash3d-fwgs() {
    CFLAGS="" ./waf configure -T release
    CFLAGS="" ./waf build    
    md_ret_require=(
        "$md_build/build/game_launch/xash3d"
        "$md_build/build/engine/libxash.so"
    )
}

function install_xash3d-fwgs() {
    ./waf install
}

function configure_xash3d-fwgs() {
    mkRomDir "ports"
    mkRomDir "ports/$md_id"
    mkRomDir "ports/$md_id/standard"
    mkRomDir "ports/$md_id/shareware"
    
    wget "http://icculus.org/xash3d-fwgs/share/1xash3d-fwgs13.zip" -O 1xash3d-fwgs13.zip
    unzip -L -o 1xash3d-fwgs13.zip xash3d-fwgssw13.shr
    unzip -L -o xash3d-fwgssw13.shr -d "$romdir/ports/$md_id/shareware" huntbgin.wad huntbgin.rtc huntbgin.rtl remote1.rts
    mv  "$romdir/ports/$md_id/shareware/remote1.rts" "$romdir/ports/$md_id/shareware/REMOTE1.RTS"
    mv  "$romdir/ports/$md_id/shareware/huntbgin.wad" "$romdir/ports/$md_id/shareware/HUNTBGIN.WAD"
    mv  "$romdir/ports/$md_id/shareware/huntbgin.rtc" "$romdir/ports/$md_id/shareware/HUNTBGIN.RTC"
    mv  "$romdir/ports/$md_id/shareware/huntbgin.rtl" "$romdir/ports/$md_id/shareware/HUNTBGIN.RTL"
    moveConfigDir "$home/.xash3d-fwgs" "$md_conf_root/xash3d-fwgs"

    addPort "$md_id" "xash3d-fwgs" "xash3d-fwgs - Rise of the Triad port" "$md_inst/bin/xash3d-fwgs"
    addPort "$md_id" "xash3d-fwgs-shareware" "xash3d-fwgs - Rise of the Triad port Shareware" "$md_inst/bin/xash3d-fwgs-shareware"
}
