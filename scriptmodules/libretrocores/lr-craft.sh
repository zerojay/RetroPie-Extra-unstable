#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-craft"
rp_module_desc="Craft - a libretro-based Minecraft clone"
rp_module_menus="4+"
rp_module_flags="!arm"

function sources_lr-craft() {
    gitPullOrClone "$md_build" https://github.com/libretro/Craft.git
}

function build_lr-craft() {
    make -f Makefile.libretro clean
    make -f Makefile.libretro 
    md_ret_require="$md_build/craft_libretro.so"
}

function install_lr-craft() {
    md_ret_files=(
        'craft_libretro.so'
    )
}

function configure_lr-craft() {
    mkRomDir "craft"
    ensureSystemretroconfig "lr-craft"

    addSystem 0 "$md_id" "lr-craft" "$md_inst/craft_libretro.so"
}
