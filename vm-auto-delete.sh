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
# Released under GNU/GPL3 
# see here: https://www.gnu.org/licenses/gpl-3.0.en.html
#
# Adjustable Parameters
# vm_dir: Voicemail directory root fullpath
# days: number of days to go back from today to start deleting messages
#
# Good to know
# logger: writes in the system log only in case of success
#
# Important: If the 'find' program it’s not found - Give Up!

days=2
vm_dir=“/var/spool/asterisk/voicemail/”

find_loc=$(command -v find)
if [ $? != 0 ]
then
        echo “Find Command not here! Giving Up!”
else
        logger $(date) Executed Vociemail Cleanup: All messages older than $days days have been deleted
        $find_loc $vm_dir -name “msg*” -mtime +$days -type f -exec rm -rf {} \;
fi
