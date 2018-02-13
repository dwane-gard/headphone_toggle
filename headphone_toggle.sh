#!/bin/bash


# Find the card that has intel in the name
COUNT=$"0"
while true; do
	DEVICE=$(amixer -c ${COUNT} info | grep Intel)

	if [[ ${DEVICE} = *"Intel"* ]]; then
		DEVICE_NUMBER="$COUNT"
		break
	else 
		COUNT=$[$COUNT +1]
	fi
done

OUTPUT="$(amixer -c ${DEVICE_NUMBER} get 'Auto-Mute Mode' | grep -o 'Item0: .*')"

if [[ ${OUTPUT} = "Item0: 'Disabled'" ]]
	then
		# set Auto-Mute to enabld
		echo "[+] Turning speakers off"
		amixer -c ${DEVICE_NUMBER} set 'Auto-Mute Mode' Enabled > /dev/null
	else
		# set Auto-Mute to disabled
		echo "[+] Turning speakers on"
		amixer -c ${DEVICE_NUMBER} set 'Auto-Mute Mode' Disabled > /dev/null
fi

