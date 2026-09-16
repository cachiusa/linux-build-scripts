A legacy of https://android.googlesource.com/kernel/build/+/670b2ff547c0739352a200422e4e8a7149145947

# Manual

```
kernel tree <--- run build scripts from HERE
├── android      example:
├── arch         $ ./build/build.sh
├── block
├── build <--- clone this repo HERE
├── certs
├── crypto
├── Documentation
├── drivers
├── fs
├── include
...
```

## options.sh

Change the build options

Use a text editor to edit this file

## build.sh

Full kernel build script

### Usage

    build/build.sh <make options>*

### Example
To enable verbose output:

    build/build.sh V=1

To use 24 concurrent build jobs:

    build/build.sh -j24

## make

Wrapper script to run `make` commands

### Example
    build/make menuconfig|config|nconfig|... 
