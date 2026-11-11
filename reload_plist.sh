#!/bin/bash

LABEL="com.maclocalapi.start"
PLIST_PATH="$HOME/Library/LaunchAgents/${LABEL}.plist"

echo "plutil check"
plutil "$PLIST_PATH"

echo "Exclude from quarantine"
xattr -d com.apple.quarantine "$PLIST_PATH"

echo "Stopping & Booting out"
# Убиваем процесс и выгружаем старую конфигурацию
launchctl kickstart -k gui/$(id -u)/$LABEL 2>/dev/null
launchctl bootout gui/$(id -u) "$PLIST_PATH" 2>/dev/null

echo "Fixing permissions & ownership"
# Файл должен принадлежать текущему пользователю и иметь права 644
chown $(whoami) "$PLIST_PATH"
chmod 644 "$PLIST_PATH"

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)

# import to get API_PATH
source "$SCRIPT_DIR/env.sh"

echo "API path: $API_PATH"

echo "Launching"

launchctl bootstrap gui/$(id -u) "$PLIST_PATH"

echo "Verification"

launchctl print gui/$(id -u)/$LABEL >/dev/null Co2>&1 && echo "Status: RUNNING" || echo "Status: NOT RUNNING"
