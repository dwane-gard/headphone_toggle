#!/bin/bash


# Cycle through available cards and Find the card that has intel in the name
COUNT=$"0"
while true; do
	DEVICE=$(amixer -c ${COUNT} info)
	
	# If device found record card number
	if [[ ${DEVICE} = *"Realtek ALC1150"* ]]; then
		DEVICE_NUMBER="$COUNT"
		break

	# If error message assume that the card does not exist
	elif [[ ${DEVICE} = *"Invalid card number"* ]]; then
		echo "[!] Card not found, Exiting"	
		exit 1

	# Else keep counting and look again
	else 
		COUNT=$[$COUNT +1]
	fi
done

# Get status of 'Auto-Mute Mode"
OUTPUT="$(amixer -c ${DEVICE_NUMBER} get 'Auto-Mute Mode' | grep -o 'Item0: .*')"

# If Auto-Mute is disables enable it
if [[ ${OUTPUT} = "Item0: 'Disabled'" ]]
	then
		# set Auto-Mute to enabld
		echo "[+] Turning speakers off"
		amixer -c ${DEVICE_NUMBER} set 'Auto-Mute Mode' Enabled > /dev/null

# If Auto-Mute is enabled disable it
else
		# set Auto-Mute to disabled
		echo "[+] Turning speakers on"
		amixer -c ${DEVICE_NUMBER} set 'Auto-Mute Mode' Disabled > /dev/null
fi

