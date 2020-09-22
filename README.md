# RetroPie-Extra-unstable

You are most likely looking for https://github.com/zerojay/RetroPie-Extra.

This repository is for holding all of my work that isn't ready for inclusion in RetroPie-Extra for various reasons: unfinished, not working, etc...

#### Testing
##### Emulators
- [ ] - beebem.sh - BBC Micro emulator - Working, won't run game from command line. Disk load issue fixed.  

##### libretrocores
- [ ] - lr-craft.sh - libretro-based Minecraft clone - Does not work on Pi due to missing OpenGLES2 support. Would require a version of RetroArch compiled against OpenGL. Not happening.  
- [ ] - lr-sameboy.sh - Gameboy/Gameboy Color emulator for libretro - Something about how RetroPie-Setup compiles causes this to fail and I'm unsure why. Might be too heavy for Raspberry Pi 3 but seems fine on ODROID XU4.

##### Ports
- [ ] - abuse.sh - Classic action game - Appears to have some stability issues as well as problems with sound/audio dropping out. Does not full screen properly yet.  
- [ ] - alephone-community.sh - Additional scenarios for AlephOne - Some instability with Alephone on Raspberry Pi. Working on it.  
- [ ] - caveexpress.sh - Cave Express game - Not working, some major compilation issues.
- [ ] - extremetuxracer.sh - Extreme Linux racing game - ???
- [ ] - f2bgl.sh - Fade To Black engine - Segfaults on launch.  
- [ ] - freegish.sh - Gish clone - Runs with glshim however very, very slowly. Might need some additional glshim options.  
- [ ] - fruity.sh - Fruity Game - Runs but in a tiny corner of the bottom left of the screen showing objects loaded into RAM and such.
- [ ] - kodi.sh - Media Player - Installs v16 for Raspbian Jessie ONLY. Currently untested.  
- [ ] - maelstrom.sh - Classic Mac Asteroids Remake - Fails to compile under Buster, must be fixed upstream. 
- [ ] - minetest.sh - Minecraft Clone - Tested and works with lowest resolution and settings, burningsvideo driver. Embed low options as default?  
- [ ] - moonlight.sh - Open Source nVidia GameStreaming - A newer package is available, currently untested.  
- [ ] - openfodder.sh - Open source Cannon Fodder engine - Instable, crashes during second mission.  
- [ ] - roadfighter.sh - Open source remake of Konami's Road Fighter - Cannot compile as is under Stretch, bug is upstream.
- [ ] - retrobattle.sh - No longer compiles under Stretch. Error is upstream.
- [ ] - rockbot.sh - Open source Megaman style game - Cannot be compiled on Pi anymore, need new compilatin instructions.
- [ ] - smw-netplay.sh - Super Mario War with netplay - Crashes before match starts.
- [ ] - supertuxkart.sh - Unplayable performance.
- [ ] - umario.sh - Super Mario Bros. Remake - Runs but doesn't scale properly. Fix incoming soon.
- [ ] - zelda3t.sh - Zelda fangame - Seems to be stuttery and glitchy looking even on an overclocked pi3. Defaults to french.

##### Supplementary
- [ ] - moonlight.sh - Unfinished, DO NOT USE.

##### Support Scripts
- [ ] - exodos-setup.sh - Setup script for adding working eXoDOS collection to EmulationStation - Not completed yet. See https://github.com/zerojay/RetroPie-Extra/issues/76

### Hall of Fame - Scripts accepted into RetroPie-Extra
- [X] - freedink.sh - Dink Smallwood engine - Lots of flicker on sprites and text, currently solved. Tested and works well.  
