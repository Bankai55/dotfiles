#!/usr/bin/env bash

# Function to get current brightness percentage
function get_brightness {
    BRIGHTNESS_LEVEL=$(brightnessctl -d nvidia_wmi_ec_backlight get)
    MAX_BRIGHTNESS_LEVEL=$(brightnessctl -d nvidia_wmi_ec_backlight max)

    # Basic validation for brightness values (optional, but good practice)
    if ! [[ "$BRIGHTNESS_LEVEL" =~ ^[0-9]+$ ]] || ! [[ "$MAX_BRIGHTNESS_LEVEL" =~ ^[0-9]+$ ]] || [[ "$MAX_BRIGHTNESS_LEVEL" -eq 0 ]]; then
        # You can remove this error message if you prefer the script to fail silently
        # echo "Error: Invalid brightness values. Level: '$BRIGHTNESS_LEVEL', Max: '$MAX_BRIGHTNESS_LEVEL'" >&2
        exit 1 # Exit the script if values are invalid
    fi

    BRIGHTNESS_PERCENT=$(( BRIGHTNESS_LEVEL * 100 / MAX_BRIGHTNESS_LEVEL ))
    echo "$BRIGHTNESS_PERCENT" # This is the value returned by the function
}

# Function to send notification via notify-send (picked up by swaync)
function notify_brightness() {
    BRIGHTNESS=$(get_brightness) # Call the function and store its output

    # Fallback in case BRIGHTNESS is somehow empty (shouldn't be with proper error handling)
    if [ -z "$BRIGHTNESS" ]; then
        BRIGHTNESS="N/A"
    fi

    notify-send -t 1000 -h string:x-canonical-private-synchronous:brightness_osd "Brightness" "Current Brightness: ${BRIGHTNESS}%" -i "display-brightness"
}

# Check argument and adjust brightness
if [[ "$1" == "inc" ]]; then
    brightnessctl set +5% > /dev/null # Suppress output to terminal
    notify_brightness
elif [[ "$1" == "dec" ]]; then
    brightnessctl set 5%- > /dev/null # Suppress output to terminal
    notify_brightness
# You can remove the 'else' block if you are only calling it with 'inc'/'dec'
# else
#    echo "Usage: $0 [inc|dec]" >&2
#    exit 1
fi
