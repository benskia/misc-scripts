#!/usr/bin/bash

isRoot () {
    if [[ "$EUID" -ne 0 ]]; then
        echo "Run as root to change charge thresholds (sudo ./toggle-charge.sh)"
        exit 1
    fi
}

while getopts m: flag
do
    case "${flag}" in
        m) mode=${OPTARG};;
    esac
done

if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: ./toggle-charge.sh <option> [arg]"
    echo ""
    echo "-h            Print this help information"
    echo "-m            Mode"
    echo "      ls      List charge information"
    echo "      health  Print battery's percent of full energy spec"
    echo "      mid     Set mid charge (for prolonged plug-in)"
    echo "      max     Set max charge (for portable use)"
    echo ""
    exit 0
fi

if [[ $mode == "ls" ]]; then
    chargeStart=`cat /sys/class/power_supply/BAT0/charge_control_start_threshold`
    chargeEnd=`cat /sys/class/power_supply/BAT0/charge_control_end_threshold`
    chargeStatus=`cat /sys/class/power_supply/BAT0/status`

    echo "Charge start: $chargeStart"
    echo "Charge end: $chargeEnd"
    echo "Charge status: $chargeStatus"
    exit 0

elif [[ $mode == "health" ]]; then
    fullEnergyDesign=`cat /sys/class/power_supply/BAT0/energy_full_design`
    fullEnergyActual=`cat /sys/class/power_supply/BAT0/energy_full`

    percentCapacity=`echo "$fullEnergyActual / $fullEnergyDesign * 100" | bc -l`

    echo "Percent capacity: $percentCapacity"
    exit 0

elif [[ $mode == "mid" ]]; then
    isRoot
    midStart=45
    midEnd=50

    echo "Setting charge start to $midStart"
    echo $midStart | tee /sys/class/power_supply/BAT0/charge_control_start_threshold
    echo "Setting charge end to $midEnd"
    echo $midEnd | tee /sys/class/power_supply/BAT0/charge_control_end_threshold
    exit 0

elif [[ $mode == "max" ]]; then
    isRoot
    maxStart=80
    maxEnd=90

    echo "Setting charge start to $maxStart"
    echo $maxStart | tee /sys/class/power_supply/BAT0/charge_control_start_threshold
    echo "Setting charge end to $maxEnd"
    echo $maxEnd | tee /sys/class/power_supply/BAT0/charge_control_end_threshold
    exit 0
fi

echo "Invalid or missing arg"
echo "Usage: toggle-charge.sh -m <mode>"
exit 1
