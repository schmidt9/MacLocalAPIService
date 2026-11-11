MacOS helper to use https://github.com/scouzi1966/maclocal-api as launchctl agent (start on Mac boot)

# General setup

1. Install maclocal-api with HomeBrew
2. Copy `/opt/homebrew/bin/afm.plist` to `~/Library/LaunchAgents`
3. Make `reload_plist.sh` executable with `chmod +x reload_plist.sh` and run it. This script helps to setup agent and troubleshoot launch errors like "Bootstrap failed: 5: Input/output error"
