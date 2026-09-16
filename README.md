# Manual

All commands must be run from the top directory of Linux source

## options.sh

Change the build options

Use a text editor to edit this file

## build.sh

Full kernel build script

### Usage

    build/build.sh <make options>*

### Examples:
To enable verbose output:

    build/build.sh V=1

To use 24 concurrent build jobs:

    build/build.sh -j24


## make

Wrapper script to run `make` commands

### Example:
    build/make menuconfig|config|nconfig|... 
