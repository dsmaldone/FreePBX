# FreePBX
Useful Stuff to use in/with FreePBX and Asterisk 

	vm-auto-delete.sh
	=================

 		A Simple Tool to Automatically Remove Voicemail Messages older than X days
		Hint: chmod 700 the file and place it under cron.daily directory or call it in your crontab
		
		# The scripr accepts 0 or 1 optional cli parameters.
		# Optional Parameter: a comma separated value of all extension's voicemail to be deleted. 
		# If no argument is input, voicemails alder than X days of all the existing extensions will be deleted.
		# Usage: vm-auto-delete.sh [<ext1,ext2,ext3...>]
		#
		# Adjustable Parameters
		# vm_dir: Voicemail directory root fullpath
		# days: number of days to go back from today to start deleting messages
		
		

