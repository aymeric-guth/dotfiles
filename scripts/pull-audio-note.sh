#!/bin/sh

cd /run/media/yul/IC\ RECORDER/REC_FILE || exit 1
cp -r FOLDER01/* /home/yul/Music/FOLDER01/
mpc update --wait
