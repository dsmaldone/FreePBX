# FreePBX
Useful Stuff to use in/with FreePBX and Asterisk 

	vm-auto-delete.sh
	=================

 		A Simple Tool to Automatically Remove Voicemail Messages older than X days
		Hint: chmod 700 the file and place it under cron.daily directory or call it in your crontab
		# Adjustable Parameters
		# vm_dir: Voicemail directory root fullpath
		# days: number of days to go back from today to start deleting messages
