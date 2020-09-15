#!/usr/bin/env bash
 
# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#
 
rp_module_id="openxcom"
rp_module_desc="OpenXCOM - Open Source X-COM Engine"
rp_module_licence="GPL3 https://raw.githubusercontent.com/SupSuper/OpenXcom/master/LICENSE.txt"
rp_module_help="Be sure to install your original data files to the proper folders in $md_inst/share/openxcom/. Game requires a mouse or xboxdrv to allow your controller to emulate a mouse. Because this uses X, you may find that the game is small in the middle of the screen. Use the Runcommand option to set the resolution to 720x480 16:9 or similarly smaller sizes. This will allow you to control the game as the window will have focus and also fill up more of the screen."
rp_module_section="exp"
rp_module_flags="!mali !x86"
 
function depends_openxcom() {
     getDepends cmake xorg libsdl1.2-dev libsdl-mixer1.2-dev libsdl-image1.2-dev libsdl-gfx1.2-dev libyaml-cpp-dev
}

function sources_openxcom() {
    gitPullOrClone "$md_build" https://github.com/SupSuper/OpenXCOM.git
}
 
function build_openxcom() {
    cd "$md_build/src"
    make -f Makefile.simple
    md_ret_require="$md_build/bin/openxcom"
}

function install_openxcom() {
    md_ret_files=(
          'bin/openxcom'
          'bin/common'
          'bin/UFO'
          'bin/TFTD'
          'bin/standard'
    )
}
 
function configure_openxcom() {
    mkdir "ports"
    moveConfigDir "$home/.config/openxcom" "$md_conf_root/openxcom"
    addPort "$md_id" "openxcom" "OpenXCOM - Open Source X-COM Engine" "pushd $md_inst; sudo xinit $md_inst/openxcom; popd"
    #addPort "$md_id" "openxcom" "OpenXCOM - Open Source X-COM Engine" "LD_LIBRARY_PATH=/opt/retropie/supplementary/glshim LIBGL_FB=1 sudo xinit $md_inst/bin/openxcom"
}
