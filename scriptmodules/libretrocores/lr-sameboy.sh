#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-sameboy"
rp_module_desc="Gameboy/Gameboy Color emulator - SameBoy Port for libretro"
rp_module_help="ROM Extensions: .gb .gbc .zip\n\nCopy your Gameboy roms to $romdir/gb.\nCopy your Gameboy Color roms to $romdir/gbc."
rp_module_licence="GPL2"
rp_module_section="exp"

function sources_lr-sameboy() {
    gitPullOrClone "$md_build" https://github.com/libretro/sameboy.git
}

function build_lr-sameboy() {
    make clean
    make libretro CFLAGS=-Wno-error
    md_ret_require="$md_build/libretro/sameboy_libretro.so"
}

function install_lr-sameboy() {
    md_ret_files=(
        'sameboy_libretro.so'
    )
}

function configure_lr-sameboy() {
    mkRomDir "gb"
    mkRomDir "gbc"
    ensureSystemretroconfig "gb"
    ensureSystemretroconfig "gbc"

    local def=0
    isPlatform "armv6" && def=1

    addEmulator "$def" "$md_id" "gb" "$md_inst/sameboy_libretro.so"
    addEmulator "$def" "$md_id" "gbc" "$md_inst/sameboy_libretro.so"
    addSystem "gb"
    addSystem "gbc"
}
