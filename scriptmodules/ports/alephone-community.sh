#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="alephone-community"
rp_module_desc="AlephOne Community - 5 Community-Made Marathon Scenarios (1GB)"
rp_module_menus="4+"
rp_module_flags="!x11 !mali"

function configure_alephone-community() {
    mkRomDir "ports"
    mkRomDir "ports/alephone/"

    if [[ ! -f "$romdir/ports/alephone/Marathon EVIL/Cursed Shapes.shpA" ]]; then
        wget http://files3.bungie.org/trilogy/MarathonEvil.zip
        unzip MarathonEvil.zip -d "$__tmpdir/"
        mv "$__tmpdir/Marathon EVIL" "$romdir/ports/alephone/"
        rm -rf "$__tmpdir/Marathon EVIL"
        rm MarathonEvil.zip
    fi

    if [[ ! -f "$romdir/ports/alephone/Tempus_Irae/Shapes.shpA" ]]; then
        wget http://nardofiles.bungie.org/Tempus_Irae.zip
        unzip Tempus_Irae.zip -d "$__tmpdir/"
        mv "$__tmpdir/Tempus_Irae" "$romdir/ports/alephone/"
        rm -rf "$__tmpdir/Tempus_Irae"
        rm Tempus_Irae.zip
    fi

    if [[ ! -f "$romdir/ports/alephone/Marathon RED/RED Shapes.shpA" ]]; then
        wget http://files3.bungie.org/trilogy/MarathonRED.zip
        unzip MarathonRED.zip -d "$__tmpdir/"
        mv "$__tmpdir/Marathon RED" "$romdir/ports/alephone"
        rm -rf "$__tmpdir/Marathon RED"
        rm MarathonRED.zip
    fi
    
    if [[ ! -f "$romdir/ports/alephone/Eternal 1.1.0/Eternal-Shapes.shpA" ]]; then
        wget http://eternal.bungie.org/files/_releases/EternalXv110Full.zip
        unzip EternalXv110Full.zip -d "$__tmpdir/"
        rm -rf ../__MACOSX
        mv "$__tmpdir/Eternal 1.1.0" "$romdir/ports/alephone/"
        rm -rf "$__tmpdir/Eternal 1.1.0"
        rm EternalXv110Full.zip
    fi

    if [[ ! -f "$romdir/ports/alephone/Marathon Phoenix/Phoenix Shapes.shpA" ]]; then
        wget http://simplici7y.com/items/marathon-phoenix-2/download
        mv download "Marathon_Phoenix_1.3.zip"
        unzip Marathon_Phoenix_1.3.zip -d "$__tmpdir/"
        mv "$__tmpdir/Marathon Phoenix" "$romdir/ports/alephone"
        rm -rf "$__tmpdir/Marathon Phoenix"
        rm Marathon_Phoenix_1.3.zip
    fi
    
    ourpath=${md_inst%/*}
    addPort "$md_id" "marathonevil" "Aleph One Engine - Marathon EVIL" "$ourpath/alephone/bin/alephone '$romdir/ports/alephone/Marathon EVIL/'"
    addPort "$md_id" "marathontempusirae" "Aleph One Engine - Tempus Irae" "$ourpath/alephone/bin/alephone '$romdir/ports/alephone/Tempus_Irae/'"
    addPort "$md_id" "marathonred" "Aleph One Engine - Marathon RED" "$ourpath/alephone/bin/alephone '$romdir/ports/alephone/Marathon RED/'"
    addPort "$md_id" "marathoneternal" "Aleph One Engine - Eternal" "$ourpath/alephone/bin/alephone '$romdir/ports/alephone/Eternal 1.1.0/'"
    addPort "$md_id" "marathonphoenix" "Aleph One Engine - Marathon Phoenix" "$ourpath/alephone/bin/alephone '$romdir/ports/alephone/Marathon Phoenix/'"
    __INFMSGS+=("These games require the alephone source port to be installed to run. To get the games running, make sure to set each game to use the software renderer and disable the enhanced HUD from the Plugins menu.")

}
