# Miscellaneous Scripts

Just some scripts I've found useful.

## TMUX Sessionizer

ThePrimeagen's sessionizer script, adapted for my workflow. Small edit to
re-attach if a server is live. Previously, subsequent runs while a server was
live would not re-attach to the server.

### Usage

1. Update roots array with locations you would like listed by the sessionizer.
2. Add shortcuts to shell and TMUX configs to run this script. I like `Prefix
F` within TMUX and `CTRL + F` without.

## Battery Charge Threshold

A bash CLI tool to list Thinkpad battery stats and toggle charge thresholds. To
change charge thresholds, must be run as root (such as with sudo).

`./toggle-charge.sh -m <mode>`

### Modes

ls
: Lists current thresholds and charging status.

health
: Calculates the full energy potential by dividing the battery's actual full
energy amount by the full energy design specification.

mid
: Maintains a 45% to 50% charge.  This is ideal when the laptop is plugged in
for long periods of time.

max
: Maintains an 80% to 90% charge. Suitable for when you anticipate using the
laptop without an AC adapter. Avoids full charge to favor battery health.
