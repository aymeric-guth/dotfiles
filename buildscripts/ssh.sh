#!/bin/sh

sudo launchctl unload /System/Library/LaunchDaemons/ssh.plist
sudo port load openssh
