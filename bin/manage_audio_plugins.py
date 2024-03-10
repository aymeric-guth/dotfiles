#!/usr/bin/env python3
import os
import sys
import time
import subprocess

extensions = {
    ".component",
    '.aaxplugin',
#    '(m).vst',
    '.component',
    '.vst',
    ".vst3",
}

do_not_move = {
    "FabFilter Pro-Q 2 (Mono)",
    "FabFilter Pro-Q 2",
    "FabFilter Pro-C 2",
    "FabFilter Pro-C 2 (Mono)",
    "MJUC",
    "The Glue",
    "EchoBoy",
    "EchoBoyJr",
    "LittleAlterBoy",
    "bx_solo",
    "ValhallaVintageVerb",
    "ValhallaSpaceModulator",
    "ValhallaRoom",

    'AppleAES3Audio',

    "chipsounds",
    "chipsynth SFC",
    "chipsynth MD",
    "chipsounds Multi",
    "Diva",
    "Reason Rack Plugin",
    "M-Tron Pro",

    "iZotope RX 5 De-clip",
    "iZotope RX 5 Dialogue De-noise",
    "iZotope Meter Tap",
    "iZotope RX 5 De-reverb",
    "iZotope RX 5 Monitor",
    "iZotope Insight",
    "iZotope RX 5 Connect",
    "iZotope RX 5 De-noise",
    "iZotope RX 5 De-click",
    "iZRX5MonitorAUHook",
    "iZRX5DereverbAUHook",
    "iZMeterTapAUHook",
    "iZRX5DenoiserAUHook",
    "iZRX5DialogueDenoiserAUHook",
    "iZRX5DeclickerAUHook",
    "iZRX5DecracklerAUHook",
    "iZInsightAUHook",
    "iZRX5DeclipperAUHook",
    "iZRX5ConnectAUHook",
    "iZRX5HumRemovalAUHook",
    "iZotope RX 5 De-hum",
    "iZotope RX 5 De-crackle",

    'Console Recall',
    'UAD AKG BX 20',
    'UAD Ampeg SVTVR Classic',
    'UAD bx_refinement',
    'UAD bx_tuner',
    'UAD CS-1',
    'UAD elysia mpressor',
    'UAD ENGL E765 RT',
    'UAD Fairchild 660',
    'UAD Fairchild 670 Legacy',
    'UAD Fairchild 670',
    'UAD Fender 55 Tweed Deluxe',
    'UAD Galaxy Tape Echo',
    'UAD Helios Type 69 Legacy',
    'UAD Lexicon 224',
    'UAD Little Labs IBP',
    'UAD Marshall Plexi Classic',
    'UAD Neve 1073',
    'UAD Neve 1073 Legacy',
    'UAD Neve 1073SE Legacy',
    'UAD Oxide Tape',
    'UAD Precision Channel Strip',
    'UAD Precision Delay Mod L',
    'UAD Precision Delay Mod',
    'UAD Precision Enhancer Hz',
    'UAD Precision Reflection Engine',
    'UAD Pultec EQP-1A Legacy',
    'UAD Pultec-Pro Legacy',
    'UAD Raw',
    'UAD RealVerb-Pro',
    'UAD Softube Amp Room Half-Stack',
    'UAD Softube Bass Amp Room 8x10',
    'UAD Teletronix LA-2A Legacy',
    'UAD UA 1176LN Legacy',
    'UAD UA 1176SE Legacy',
    'UAD UA 610-B',
}
dirs = [
    # "/Library/Application Support/Universal Audio/UAD-2 Powered Plug-Ins/",
    "/Library/Audio/Plug-Ins/Components/",
    "/Library/Audio/Plug-Ins/VST/",
    # "/Library/Audio/Plug-Ins/VST/Powered Plug-Ins/",
    # "/Library/Audio/Plug-Ins/VST/Powered Plug-Ins/Mono/",
    # "/Library/Audio/Plug-Ins/VST/Plugin Alliance/",
    "/Library/Audio/Plug-Ins/VST3/",
]
def purge_dir(path):
    with os.scandir(path) as dir_content:
        for file in dir_content:
            filename, extension = os.path.splitext(file.name)
            if extension in extensions and filename not in do_not_move and extension:
                print(f"Deleting {file.path}")
                subprocess.run(["sudo", "rm", "-r", file.path])

# [ purge_dir(i) for i in dirs ]
for i in dirs:
    try:
        purge_dir(i)
    except Exception:
        ...

try:
    os.chdir("/Library/Application Support/Avid/")
    subprocess.run(["sudo", "rm", "-r", "/Library/Application Support/Avid/"])
    print("AAX Folder Deleted.")
except FileNotFoundError:
    print("No AAX Folder Found.")
    pass

try:
    os.chdir("/Library/Application Support/Digidesign/")
    subprocess.run(["sudo", "rm", "-r", "/Library/Application Support/Digidesign/"])
    print("AAX Folder Deleted.")
except FileNotFoundError:
    print("No AAX Folder Found.")
    pass
#maintenance et verif new version logiciels audio

#Fabfilter Pro C2
#Fabfilter Pro Q2
#MJUC Klanghelm
#Soundtoys Echoboy
#Soundtoys Echoboy Jr
#Soundtoys Little Alter Boy
#Cytomic The Glue
#Valhalla DSP ValhallaRoom
#Valhalla DSP ValhallaVintageVerb

#Plogue Chipsound
#Plogue SFC
#U-He Diva
