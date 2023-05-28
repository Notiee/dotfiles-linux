#!/bin/sh

# A dwm_bar function to read the battery level and status
# Joe Standring <git@joestandring.com>
# GNU GPLv3

dwm_battery () {
    # Change BAT1 to whatever your battery is identified as. Typically BAT0 or BAT1
    CHARGE=$(cat /sys/class/power_supply/BAT1/capacity) #| sed -e 's/\ *$//g' # | sed -e '..' (remove trailing whitespace)
    STATUS=$(cat /sys/class/power_supply/BAT1/status)

    printf "%s" "$SEP1"
    if [ "$IDENTIFIER" = "unicode" ]; then
        if [ "$STATUS" = "Charging" ]; then
            printf "🔌 %s%% %s" "$CHARGE" "$STATUS"
        else
            printf "🔋 %s%% %s" "$CHARGE" "$STATUS"
        fi
    else
        if [ "$STATUS" = "Charging" ]; then
            printf "⚡ ⇋ %s%%" "$CHARGE"
        elif [ "$STATUS" = "Full" ]; then
            printf "⚡ ^ %s%%" "$CHARGE"
        elif [ "$STATUS" = "Not charging" ]; then
            printf "⚡ ꓿ %s%%" "$CHARGE"
        else
            if [ "$CHARGE" -le 15 ]; then
                printf "⚡ ! %s%%" "$CHARGE"
            else
                printf "⚡ ~ %s%%" "$CHARGE"
            fi
        fi
    fi
    printf "%s\n" "$SEP2"
}

dwm_battery

