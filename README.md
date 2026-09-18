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
├── Build.options <-- Device build settings
...
```

## Build.options

Open your text editor and create a `Build.options` file (case-sensitive)

```
kernel tree
├── Documentation
├── drivers
...
├── Build.options <-- Place config file HERE
...
```

You can find available settings in [Build.options.sh](./Build.options.sh)

## build.sh

Full kernel build script

    ./build/build.sh <make options>*

Example

- To enable verbose output:

      ./build/build.sh V=1

- To use 24 concurrent build jobs:

      ./build/build.sh -j24

## make

Wrapper script to run `make` commands

Example

- Launch menuconfig

      ./build/make menuconfig

- Show kernel version

      ./build/make kernelrelease
