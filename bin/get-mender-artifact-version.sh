#!/bin/sh

# get artifact-id from .mender file
tar -xvf "$1"
tar -zxvf header.tar.gz
cat header-info
