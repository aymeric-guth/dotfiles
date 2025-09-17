#!/bin/sh
rsync \
	--archive \
	--exclude playlists \
	--exclude Makefile \
	--exclude .stfolder \
	--exclude .stignore \
	--exclude stignore \
	--delete \
	--verbose \
	--human-readable \
	/home/yul/Music/ \
	yul@eihwaz.nebula:'/mnt/md0/music-lib/'
ssh yul@eihwaz.nebula '/home/yul/.local/bin/gonic-refresh'
mpc update
notify-send \
	"AV/music-lib: sync done"
