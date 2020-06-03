#!/bin/sh
# A Simple Tool to Automatically Remove Voicemail Messages older than X days
# Copyright (C) 2020  dsmaldone
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# Author: dsmaldone
# Released under GNU/GPL3 see here: https://www.gnu.org/licenses/gpl-3.0.en.html
# Source: https://github.com/dsmaldone/FreePBX/blob/master/vm-auto-delete.sh
#
# Adjustable Parameters
# vm_dir: Voicemail directory root fullpath
# days: number of days to go back from today to start deleting messages
#
# Good to know
# logger: writes in the system log only in case of success
#
# Important: If the 'find' program it’s not found - Give Up!

#!/bin/sh
# A Simple Tool to remote Voicemail Messages older than $days
# vm_dir = Voicemail directory root
# days = number of days to go back to start deleting messages
# If find program it's not found - Give Up!

narg=$#

days=30
vm_dir="/var/spool/asterisk/voicemail/"


find_loc=$(command -v find)
ftest=$?

if [ $ftest != 0 ]; then
        echo "Find Command not here! Giving Up!"
        exit 2
fi

if [ $narg -gt 1 ]; then
        echo "Invalid number of arguments. Script accepts 0 or 1 argument."
        echo "If no argument is input, voicemails of all the existing extensions will be deleted."
        echo "To select 1 or more than 1 ext use comma e.g. 100 or 200,300"
        exit 1
elif [ $narg -eq 0 ]; then
        logger $(date) - Executed Vociemail Cleanup: All voicemail messages older than $days days have been deleted
        $find_loc $vm_dir -name "msg*" -mtime +$days -type f -exec rm -rf {} \;
else
        for i in $(echo $1 | sed "s/,/ /g")
        do
                curvm=$vm_dir/default/$i
                if [ -d "$curvm" ]; then
                        logger $(date) - Checking Extension $i Voicemail
                        $find_loc $curvm -name "msg*" -mtime +$days -type f -exec rm -rf {} \;
                        # Uncomment follow line for debug
                        # echo "checked $i"
                        vmchecked="${vmchecked}$i,"
                fi
        done
        logger $(date) - Executed Voicemail Cleanup: All $vmchecked messages older than $days days have been deleted
fi
