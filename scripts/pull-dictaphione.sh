#!/bin/sh

set -e

DEVICE="/dev/disk/by-id/usb-SONY_IC_RECORDER_180E94E1007251-0:0-part1"
DESTINATION="/home/yul/Music/Dictaphione"
SOURCE_DIRECTORY="REC_FILE/FOLDER01"

if [ ! -b "$DEVICE" ]; then
    /usr/bin/notify-send "Dictaphione" "Périphérique introuvable"
    exit 1
fi

REAL_DEVICE=$(/usr/bin/readlink -f "$DEVICE")

if ! /usr/bin/udisksctl mount \
    --block-device "$REAL_DEVICE" \
    --no-user-interaction
then
    /usr/bin/notify-send "Dictaphione" "Échec du montage"
    exit 1
fi

MOUNT_POINT=$(
    /usr/bin/findmnt \
        --noheadings \
        --output TARGET \
        --source "$REAL_DEVICE"
)

SOURCE="$MOUNT_POINT/$SOURCE_DIRECTORY"

/usr/bin/mkdir -p "$DESTINATION"

if ! /usr/bin/cp -a "$SOURCE/." "$DESTINATION/"; then
    /usr/bin/udisksctl unmount \
        --block-device "$REAL_DEVICE" \
        --no-user-interaction

    /usr/bin/notify-send "Dictaphone" "Échec de la copie"
    exit 1
fi

# La suppression n'arrive que si cp a réussi.
/usr/bin/find "$SOURCE" -mindepth 1 -delete

/usr/bin/sync

if ! /usr/bin/udisksctl unmount \
    --block-device "$REAL_DEVICE" \
    --no-user-interaction
then
    /usr/bin/notify-send "Dictaphione" \
        "Fichiers copiés, mais échec du démontage"
    exit 1
fi

/usr/bin/notify-send "Dictaphione" \
    "Enregistrements copiés et dictaphone démonté"
