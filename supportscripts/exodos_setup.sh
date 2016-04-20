#!/bin/bash
ourlines=0

mkdir ../Output/

for D in *; do
    if [ -d "${D}" ]; then
        if [ -s "${D}/dosbox.conf" ]; then
            sed -i 's/.$/\n/' "${D}/dosbox.conf"
	    outputfilename=`find ./"${D}" -name '*.bat' ! -iname 'install.bat' -exec sh -c 'echo "$(basename "{}" .bat)"' \;`
	    echo Processing $outputfilename...

            outputfilename=$(sed 's/  +/ /g' <<< $outputfilename)
            echo -en "#!/bin/bash\ncd /home/pi/RetroPie/roms/pc\n/opt/retropie/emulators/dosbox/bin/dosbox " > ../Output/"$outputfilename.sh"
#            echo -n "-conf ./!dos/\"${D}\"/dosbox.conf " >> ../Output/"$outputfilename.sh"
            echo -n "-c \"mount y /home/pi/RetroPie/roms/pc\" " >> ../Output/"$outputfilename.sh"
            echo -n "-c \"y:\" " >> ../Output/"$outputfilename.sh" 
            while read -r line
	    do
		
		if [ "$ourlines" -eq "1" ]; then
		   if [[ ! -z $line ]]; then
                      if [[ ! $line = \#* ]]; then
	                 echo -n " -c \"$line\"" | sed 's/\\/\//g' >> ../Output/"$outputfilename.sh"
                      fi
                   fi
                fi
		if [[ "$line" == *"[autoexec]"* ]]; then
		   ourlines=1;
		fi
            done < "${D}/dosbox.conf"
            ourlines=0;
        fi
    fi
done


# find . -name '*.bat' ! -name 'install.bat' -exec sh -c 'echo "$(basename "{}" .bat)"' \;
