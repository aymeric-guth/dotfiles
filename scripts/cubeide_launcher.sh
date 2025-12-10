#!/bin/sh

rm -f "$HOME"/STM32CubeIDE/workspace_1.19.0/.metadata/.lock
env GDK_SCALE=2 /opt/st/stm32cubeide_1.19.0/stm32cubeide_wayland "$*"
