#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="moonlight"
rp_module_desc="moonlight game streaming"
rp_module_licence="MIT https://raw.githubusercontent.com/sselph/scraper/master/LICENSE"
rp_module_section="exp"

function depends_moonlight() {
    if grep -q "deb http://archive.itimmer.nl/raspbian/moonlight jessie main" /etc/apt/sources.list; then

    else
	echo "deb http://archive.itimmer.nl/raspbian/moonlight jessie main" >> /etc/apt/sources.list
    fi
    if [ -f /home/pi/itimmer.gpg ] then	

    else		
        wget http://archive.itimmer.nl/itimmer.gpg
	chown pi:pi /home/pi/itimmer.gpg
	apt-key add itimmer.gpg		
    fi
    apt-get update -y
}

function install_moonlight() {
    apt-get update -y
    apt-get install moonlight-embedded -y
}

function get_ver_moonlight() {
    [[ -f "$md_inst/scraper" ]] && "$md_inst/scraper" -version 2>/dev/null
}

function latest_ver_moonlight() {
    wget -qO- https://api.github.com/repos/sselph/scraper/releases/latest | grep -m 1 tag_name | cut -d\" -f4
}

function list_systems_moonlight() {
    find -L "$romdir" -mindepth 1 -maxdepth 1 -not -empty -type d | sort
}

function scrape_moonlight() {
    local system="$1"
    [[ -z "$system" ]] && return

    iniConfig " = " '"' "$configdir/all/scraper.cfg"
    eval $(_load_config_scraper)

    local gamelist
    local img_dir
    local img_path
    if [[ "$use_rom_folder" -eq 1 ]]; then
        gamelist="$romdir/$system/gamelist.xml"
        img_dir="$romdir/$system/images"
        img_path="./images"
    else
        gamelist="$home/.emulationstation/gamelists/$system/gamelist.xml"
        img_dir="$home/.emulationstation/downloaded_images/$system"
        img_path="~/.emulationstation/downloaded_images/$system"
    fi

    local params=()
    params+=(-image_dir "$img_dir")
    params+=(-image_path "$img_path")
    params+=(-video_dir "$img_dir")
    params+=(-video_path "$img_path")
    params+=(-marquee_dir "$img_dir")
    params+=(-marquee_path "$img_path")
    params+=(-output_file "$gamelist")
    params+=(-rom_dir "$romdir/$system")
    params+=(-workers "4")
    params+=(-skip_check)
    if [[ "$use_thumbs" -eq 1 ]]; then
        params+=(-thumb_only)
    fi
    if [[ "$download_videos" -eq 1 ]]; then
        params+=(-download_videos)
    fi
    if [[ "$download_marquees" -eq 1 ]]; then
        params+=(-download_marquees)
    fi
    if [[ -n "$max_width" ]]; then
        params+=(-max_width "$max_width")
    fi
    if [[ -n "$max_height" ]]; then
        params+=(-max_height "$max_height")
    fi
    if [[ "$console_src" -eq 0 ]]; then
        params+=(-console_src="ovgdb")
    elif [[ "$console_src" -eq 1 ]]; then
        params+=(-console_src="gdb")
    else
        params+=(-console_src="ss")
    fi
    if [[ "$mame_src" -eq 0 ]]; then
        params+=(-mame_src="mamedb")
    elif [[ "$mame_src" -eq 1 ]]; then
        params+=(-mame_src="ss")
    else
        params+=(-mame_src="adb")
    fi
    if [[ "$rom_name" -eq 1 ]]; then
        params+=(-use_nointro_name=false)
    elif [[ "$rom_name" -eq 2 ]]; then
        params+=(-use_filename=true)
    fi
    if [[ "$append_only" -eq 1 ]]; then
        params+=(-append)
    fi

    [[ "$system" =~ ^mame-|arcade|fba|neogeo ]] && params+=(-mame -mame_img t,m,s)

    # trap ctrl+c and return if pressed (rather than exiting retropie-setup etc)
    trap 'trap 2; return 1' INT
    sudo -u $user "$md_inst/scraper" ${params[@]}
    trap 2
}

function scrape_all_scraper() {
    local system
    while read system; do
        system=${system/$romdir\//}
        scrape_scraper "$system" "$@" || return 1
    done < <(list_systems_scraper)
}

function scrape_chosen_moonlight() {
    local options=()
    local system
    local i=1
    while read system; do
        system=${system/$romdir\//}
        options+=($i "$system" OFF)
        ((i++))
    done < <(list_systems_scraper)

    if [[ ${#options[@]} -eq 0 ]] ; then
        printMsgs "dialog" "No populated rom folders were found in $romdir."
        return
    fi

    local cmd=(dialog --backtitle "$__backtitle" --checklist "Select ROM Folders" 22 76 16)
    local choice=($("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty))

    [[ ${#choice[@]} -eq 0 ]] && return

    local choice
    for choice in "${choice[@]}"; do
        choice=${options[choice*3-2]}
        scrape_scraper "$choice" "$@"
    done
}

function _load_config_moonlight() {
    echo "$(loadModuleConfig \
        'ip=0.0.0.0' \
    )"
}

function gui_moonlight() {
    if pgrep "emulationstatio" >/dev/null; then
        printMsgs "dialog" "This scraper must not be run while Emulation Station is running or the scraped data will be overwritten. \n\nPlease quit from Emulation Strun RetroPie-Setup from the terminal"
        return
    fi


    iniConfig " = " '"' "$configdir/all/moonlight.cfg"
    eval $(_load_config_moonlight)
    chown $user:$user "$configdir/all/moonlight.cfg"

    local default
    while true; do
        local cmd=(dialog --backtitle "$__backtitle" --default-item "$default" --menu "Moonlight Streaming" 22 76 16)
        local options=(
            1 "Pair with your PC"
            2 "Create Steam System"
            3 "Create scripts"
        )

        if [[ "$mame_src" -eq 0 ]]; then
            options+=(4 "Arcade Source (MameDB)")
        elif [[ "$mame_src" -eq 1 ]]; then
            options+=(4 "Arcade Source (ScreenScraper)")
        else
            options+=(4 "Arcade Source (ArcadeItalia)")
        fi

        if [[ "$console_src" -eq 0 ]]; then
            options+=(5 "Console Source (OpenVGDB)")
        elif [[ "$console_src" -eq 1 ]]; then
            options+=(5 "Console Source (thegamesdb)")
        else
            options+=(5 "Console Source (ScreenScraper)")
        fi

        if [[ "$rom_name" -eq 0 ]]; then
            options+=(6 "ROM Names (No-Intro)")
        elif [[ "$rom_name" -eq 1 ]]; then
            options+=(6 "ROM Names (theGamesDB)")
        else
            options+=(6 "ROM Names (Filename)")
        fi

        if [[ "$append_only" -eq 1 ]]; then
            options+=(7 "Gamelist (Append)")
        else
            options+=(7 "Gamelist (Overwrite)")
        fi

        if [[ "$use_rom_folder" -eq 1 ]]; then
            options+=(8 "Use rom folder for gamelist & images (Enabled)")
        else
            options+=(8 "Use rom folder for gamelist & images (Disabled)")
        fi

        if [[ "$download_videos" -eq 1 ]]; then
            options+=(9 "Download Videos (Enabled)")
        else
            options+=(9 "Download Videos (Disabled)")
        fi

        if [[ "$download_marquees" -eq 1 ]]; then
            options+=(0 "Download Marquees (Enabled)")
        else
            options+=(0 "Download Marquees (Disabled)")
        fi

        options+=(W "Max image width ($max_width)")
        options+=(H "Max image height ($max_height)")

        options+=(U "Update scraper to the latest version")
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        if [[ -n "$choice" ]]; then
            default="$choice"
            case "$choice" in
                1)
                    read -p "Input STEAM PC's IP Address here :`echo $'\n> '`" ip
                    sudo -u pi moonlight pair $ip
                    ;;
                2)
                    if [ -f /home/pi/.emulationstation/es_systems.cfg ]
		    then	
			echo -e "Removing Duplicate Systems File"
			rm /home/pi/.emulationstation/es_systems.cfg
		    fi
                    echo -e "Copying Systems Config File"
		    cp /etc/emulationstation/es_systems.cfg /home/pi/.emulationstation/es_systems.cfg
			
		    if grep -q "<platform>steam</platform>" /home/pi/.emulationstation/es_systems.cfg; then
			echo -e "NOTE: Steam Entry Exists - Skipping"
		    else
			echo -e "Adding Steam to Systems"
			sudo sed -i -e 's|</systemList>|  <system>\n    <name>steam</name>\n    <fullname>Steam</fullname>\n    <path>~/RetroPie/roms/moonlight</path>\n    <extension>.sh .SH</extension>\n    <command>bash %ROM%</command>\n    <platform>steam</platform>\n    <theme>steam</theme>\n  </system>\n</systemList>|g' /home/pi/.emulationstation/es_systems.cfg
		    fi
		    echo -e "\n**** PHASE SIX Complete!!!! ****"
                    ;;
                3)
                    echo -e "Create Script Folder"
     		    mkdir -p /home/pi/RetroPie/roms/moonlight
		    cd /home/pi/RetroPie/roms/moonlight
		
		    echo -e "Create Scripts"
		    if [ -f /home/pi/RetroPie/roms/moonlight/720p30fps.sh ]; then
			echo -e "NOTE: 720p30fps Exists - Skipping"
		    else
			echo "#!/bin/bash" > 720p30fps.sh
			echo "moonlight stream -720 -fps 30 "$ip"" >>  720p30fps.sh
		    fi
		
		    if [ -f /home/pi/RetroPie/roms/moonlight/720p60fps.sh ]; then
			echo -e "NOTE: 720p60fps Exists - Skipping"
		    else
			echo "#!/bin/bash" > 720p60fps.sh
			echo "moonlight stream -720 -fps 60 "$ip"" >>  720p60fps.sh
		    fi
		
		    if [ -f /home/pi/RetroPie/roms/moonlight/1080p30fps.sh ]; then
			echo -e "NOTE: 1080p30fps Exists - Skipping"
		    else
			echo "#!/bin/bash" > 1080p30fps.sh
			echo "moonlight stream -1080 -fps 30 "$ip"" >>  1080p30fps.sh
		    fi
		
		    if [ -f /home/pi/RetroPie/roms/moonlight/1080p60fps.sh ]; then
			echo -e "NOTE: 1080p60fps Exists - Skipping"
		    else
			echo "#!/bin/bash" > 1080p60fps.sh
			echo "moonlight stream -1080 -fps 60 "$ip"" >>  1080p60fps.sh
		    fi
		
		    echo -e "Make Scripts Executable"
	 	    chmod +x 720p30fps.sh
		    chmod +x 720p60fps.sh
		    chmod +x 1080p30fps.sh
		    chmod +x 1080p60fps.sh
		    echo -e "\n**** PHASE SEVEN Complete!!!! ****"
                    echo -e "Changing File Permissions"
		    chown -R pi:pi /home/pi/RetroPie/roms/moonlight/
		    chown pi:pi /home/pi/.emulationstation/es_systems.cfg

                    ;;
                4)
                    mame_src="$((( mame_src + 1) % 3))"
                    iniSet "mame_src" "$mame_src"
                    ;;
                5)
                    console_src="$((( console_src + 1) % 3))"
                    iniSet "console_src" "$console_src"
                    ;;
                6)
                    rom_name="$((( rom_name + 1 ) % 3))"
                    iniSet "rom_name" "$rom_name"
                    ;;
                7)
                    append_only="$((append_only ^ 1))"
                    iniSet "append_only" "$append_only"
                    ;;
                8)
                    use_rom_folder="$((use_rom_folder ^ 1))"
                    iniSet "use_rom_folder" "$use_rom_folder"
                    ;;
                9)
                    download_videos="$((download_videos ^ 1))"
                    iniSet "download_videos" "$download_videos"
                    ;;
                0)
                    download_marquees="$((download_marquees ^ 1))"
                    iniSet "download_marquees" "$download_marquees"
                    ;;
                H)
                    cmd=(dialog --backtitle "$__backtitle" --inputbox "Please enter the max image height in pixels" 10 60 "$max_height")
                    max_height=$("${cmd[@]}" 2>&1 >/dev/tty)
                    iniSet "max_height" "$max_height"
                    ;;
                W)
                    cmd=(dialog --backtitle "$__backtitle" --inputbox "Please enter the max image width in pixels" 10 60 "$max_width")
                    max_width=$("${cmd[@]}" 2>&1 >/dev/tty)
                    iniSet "max_width" "$max_width"
                    ;;
                U)
                    rp_callModule "$md_id"
                    ;;
            esac
        else
            break
        fi
    done
}
