#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-retro8"
rp_module_desc="Atari Lynx emulator - Handy port for libretro"
rp_module_help="ROM Extensions: .p8 .png\n\nCopy your Pico8 carts to $romdir/pico8"
rp_module_licence="GPL3 https://raw.githubusercontent.com/Jakz/retro8/master/LICENSE"
rp_module_section="exp"

function sources_lr-retro8() {
    gitPullOrClone "$md_build" https://github.com/Jakz/retro8.git
}

function build_lr-retro8() {
    make clean
    make
    md_ret_require="$md_build/retro8_libretro.so"
}

function install_lr-retro8() {
    md_ret_files=(
        'retro8_libretro.so'
        'README.md'
    )
}

function configure_lr-retro8() {
    mkRomDir "pico8"
    ensureSystemretroconfig "pico8"

    addEmulator 1 "$md_id" "pico8" "$md_inst/retro8_libretro.so" ".p8 .png .P8 .PNG"
    addSystem "pico8"
}
