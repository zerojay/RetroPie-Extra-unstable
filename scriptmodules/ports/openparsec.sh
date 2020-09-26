#!/usr/bin/env bash

rp_module_id="openparsec"
rp_module_desc="OpenParsec - There is no safe distance"
rp_module_licence="GPL2 https://raw.githubusercontent.com/OpenParsec/openparsec/master/LICENSE"
rp_module_section="exp"
rp_module_flags="!mali !osmc !xbian !x86"

function depends_openparsec() {
    getDepends libsdl2-mixer-2.0-0 libsdl2-2.0-0 libraspberrypi0
}

function sources_openparsec() {
    gitPullOrClone "$md_build/client" https://github.com/OpenParsec/openparsec.git 
    gitPullOrClone "$md_build/assets" https://github.com/OpenParsec/openparsec-assets.git
}

function build_openparsec() {
    cd $md_build/client/platforms/premake-rpi
    make client
    md_ret_require="$md_build/client/openparsec/parsec_root/client/parsec"
}

function install_openparsec() {
    md_ret_files=(
          'assets/Images'
          'assets/cons'
          'assets/LICENSE.artwork_sound'
          'client/LICENSE.readme'
          'client/LICENSE'
          'assets/README.md'
          'assets/init.con'
          'assets/openparsec.ico'
          'client/openparsec/parsec_root/client/parsec'
          'assets/planet.con'
          'assets/pscdata0.dat'
          'assets/pscdata1.dat'
          'assets/pscdata2.dat'
          'assets/pscdata3.dat'
          'client/README.txt'
    )

}

function configure_openparsec() {
    touch $md_inst/parsecrc.con
    chmod 777 $md_inst/parsecrc.con

    addPort "$md_id" "openparsec" "OpenParsec - There is no safe distance" "pushd $md_inst; ./parsec; popd" 
}
