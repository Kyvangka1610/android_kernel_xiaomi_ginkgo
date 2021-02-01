#!/usr/bin/env bash
#
# Copyright (C) 2020 Kyvangka1610
#
# Simple Local Kernel Build Script
#
# Configured for Redmi Note 8 / ginkgo custom kernel source
#
# Setup build env with akhilnarang/scripts repo
#
# Use this script on root of kernel directory

bold=$(tput bold)
normal=$(tput sgr0)

echo -e "\nStarting compilation...\n"

# Clone toolchain
if ! [ -d "$HOME/toolchain" ]; then
echo "${bold}Proton clang not found! Cloning...${normal}"
if ! git clone --depth=1 https://github.com/kdrag0n/proton-clang ~/proton; then
echo "${bold}Proton Clang Done${normal}"
exit 1
fi
fi
echo "${bold}gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu not found! Cloning...${normal}"
if ! git clone https://github.com/Kyvangka1610/gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu.git ~/gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu; then
echo "${bold}gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu Done${normal}"
exit 1
fi
echo "${bold}gcc-arm-10.2-2020.11-x86_64-arm-none-linux-gnueabihf not found! Cloning...${normal}"
if ! git clone https://github.com/Kyvangka1610/gcc-arm-10.2-2020.11-x86_64-arm-none-linux-gnueabihf.git ~/gcc-arm-10.2-2020.11-x86_64-arm-none-linux-gnueabihf; then
echo "${bold}gcc-arm-10.2-2020.11-x86_64-arm-none-linux-gnueabihf Done${normal}"
exit 1
fi

# ENV
CONFIG=vendor/sixteen_defconfig
KERNEL_DIR=$(pwd)
PARENT_DIR="$(dirname "$KERNEL_DIR")"
KERN_IMG="$HOME/out-new-Q/out/arch/arm64/boot/Image.gz-dtb"
export KBUILD_BUILD_USER="elang"
export KBUILD_BUILD_HOST="kyvangkaelang"
export PATH="$HOME/toolchain/proton-clang/bin:$PATH"
export LD_LIBRARY_PATH="$HOME/toolchain/proton-clang/lib:$LD_LIBRARY_PATH"
export KBUILD_COMPILER_STRING="$($HOME/toolchain/proton-clang/bin/clang --version | head -n 1 | perl -pe 's/\((?:http|git).*?\)//gs' | sed -e 's/  */ /g' -e 's/[[:space:]]*$//' -e 's/^.*clang/clang/')"
export out=$HOME/out-new-Q

# Functions
clang_build () {
    make -j$(nproc --all) O=$out \
                          ARCH=arm64 \
                          CC="clang" \
                          AR="llvm-ar" \
                          NM="llvm-nm" \
						  LD="ld.lld" \
			              AS="llvm-as" \
			              OBJCOPY="llvm-objcopy" \
			              OBJDUMP="llvm-objdump" \
                          CLANG_TRIPLE=aarch64-linux-gnu- \
                          CROSS_COMPILE="$HOME/toolchain/gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-" \
                          CROSS_COMPILE_ARM32="$HOME/toolchain/gcc-arm-10.2-2020.11-x86_64-arm-none-linux-gnueabihf/bin/arm-none-linux-gnueabihf-"
}

# Build kernel
make O=$out ARCH=arm64 $CONFIG > /dev/null
echo -e "${bold}Compiling with CLANG${normal}\n$KBUILD_COMPILER_STRING"
echo -e "\nCompiling $ZIPNAME\n"
clang_build
if [ -f "$out/arch/arm64/boot/Image.gz-dtb" ] && [ -f "$out/arch/arm64/boot/dtbo.img" ]; then
 echo -e "\nKernel compiled succesfully! Zipping up...\n"
 ZIPNAME="SixTeen•Kernel•Q•Ginkgo•Willow-$(date '+%Y%m%d-%H%M').zip"
 if [ ! -d AnyKernel3 ]; then
  git clone -q https://github.com/Kyvangka1610/AnyKernel3.git
 fi;
 mv -f $out/arch/arm64/boot/Image.gz-dtb AnyKernel3
 mv -f $out/arch/arm64/boot/dtbo.img AnyKernel3
 cd AnyKernel3
 zip -r9 "$HOME/$ZIPNAME" *
 cd ..
 rm -rf AnyKernel3
 echo -e "\nCompleted in $((SECONDS / 60)) minute(s) and $((SECONDS % 60)) second(s) !"
 echo -e "Zip: $ZIPNAME\n"
 rm -rf $out
else
 echo -e "\nCompilation failed!\n"
fi;