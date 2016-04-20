#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="mehstation"
rp_module_desc="mehstation"
rp_module_menus="4+"

function depends_mehstation() {
    getDepends git cmake build-essential libfreeimage-dev libopenal-dev libpango1.0-dev libsndfile1-dev libudev-dev libasound2-dev libjpeg-dev libtiff5-dev libwebp-dev automake cmake libsqlite3-dev libavutil-dev libavcodec-dev libavformat-dev libsdl2-dev libsdl2-image-dev libsdl2-ttf-dev
}

function sources_mehstation() {
    gitPullOrClone "$md_build" "https://github.com/remeh/mehstation.git"
}

function build_mehstation() {
    cmake .
    make
    md_ret_require="$md_build/mehstation"
}

function install_mehstation() {
    make install
}


#function configure_mehstation() {
#
#}
