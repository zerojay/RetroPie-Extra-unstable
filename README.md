# RetroPie-Extra-unstable

You are most likely looking for https://github.com/zerojay/RetroPie-Extra.

This repository is for holding all of my work that isn't ready for inclusion in RetroPie-Extra for various reasons: unfinished, not working, etc...

#### Testing
##### libretrocores
- [ ] - lr-craft.sh - libretro-based Minecraft clone - Does not work on Pi due to missing OpenGLES2 support. Would require a version of RetroArch compiled against OpenGL. Not happening.  
- [ ] - lr-wolfenstein.sh - libretro-based Wolfenstein 3D engine - Working quite well, just needs to have some fixups regarding its save game directories.  

##### Ports
- [ ] - abuse.sh - Classic action game - Appears to have some stability issues as well as problems with sound/audio dropping out. Does not full screen properly yet.  
- [ ] - alephone-community.sh - Additional scenarios for AlephOne - Some instability with Alephone on Raspberry Pi. Working on it.  
- [ ] - beebem.sh - BBC Micro emulator - Working, won't run game from command line. Disk load issue fixed.  
- [ ] - caveexpress.sh - Cave Express game - Not working, some major compilation issues.  
- [ ] - f2bgl.sh - Fade To Black engine - Segfaults on launch.  
- [ ] - freedink.sh - Dink Smallwood engine - Lots of flicker on sprites and text, currently unsolved. Works well otherwise.  
- [ ] - freegish.sh - Gish clone - Runs with glshim however very, very slowly. Might need some additional glshim options.  
- [ ] - kodi.sh - Media Player - Installs v16 for Raspbian Jessie ONLY. Currently untested.  
 
- [ ] - mehstation.sh - Emulator frontend - Currently untested, unfinished script. Not able to replace emulationstation yet.  
- [ ] - moonlight.sh - Open Source nVidia GameStreaming - A newer package is available, currently untested.  
- [ ] - openfodder.sh - Open source Cannon Fodder engine - Instable, crashes during second mission.  
- [ ] - umario.sh - Super Mario Bros. Remake - Runs but doesn't scale properly. Fix incoming soon.

##### Supplementary
- [ ] - exodos-setup.sh - Setup script for adding working eXoDOS collection to EmulationStation - Not completed yet. See https://github.com/zerojay/RetroPie-Extra/issues/76
