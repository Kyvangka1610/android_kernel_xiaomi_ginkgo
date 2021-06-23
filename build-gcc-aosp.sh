echo -e "\nStarting compilation...\n"

# ENV
CONFIG=vendor/sixteen_defconfig
KERNEL_DIR=$(pwd)
PARENT_DIR="$(dirname "$KERNEL_DIR")"
KERN_IMG="$HOME/out-new-R/out/arch/arm64/boot/Image.gz-dtb"
export KBUILD_BUILD_USER="elang"
export KBUILD_BUILD_HOST="kyvangkaelang"
export PATH="$HOME/toolchain/gcc-arm64/bin:$PATH"
export LD_LIBRARY_PATH="$HOME/toolchain/gcc-arm64/lib:$LD_LIBRARY_PATH"
export KBUILD_COMPILER_STRING="$($HOME/toolchain/gcc-arm64/bin/aarch64-elf-gcc --version | head -n 1 | cut -d ')' -f 2 | awk '{print $1}')"
export CROSS_COMPILE_ARM32=$HOME/toolchain/gcc-arm/bin/arm-eabi-
export out=$HOME/out-new-R

# Functions
clang_build () {
    make -j$(nproc --all) O=$out \
                          ARCH=arm64 \
                          CC="aarch64-elf-gcc" \
                          AR="aarch64-elf-ar" \
                          NM="aarch64-elf-nm" \
                          LD="aarch64-elf-ld.bfd" \
                          AS="aarch64-elf-as" \
                          OBJCOPY="aarch64-elf-objcopy" \
                          OBJDUMP="aarch64-elf-objdump" \
                          CROSS_COMPILE_ARM32=$CROSS_COMPILE_ARM32
}

# Build kernel
make O=$out ARCH=arm64 $CONFIG > /dev/null
echo -e "${bold}Compiling with GCC${normal}\n$KBUILD_COMPILER_STRING"
echo -e "\nCompiling $ZIPNAME\n"
clang_build
if [ -f "$out/arch/arm64/boot/Image.gz-dtb" ] && [ -f "$out/arch/arm64/boot/dtbo.img" ]; then
 echo -e "\nKernel compiled succesfully! Zipping up...\n"
 ZIPNAME="SixTeen•Kernel•AOSP•R•Ginkgo•Willow-$(date '+%Y%m%d-%H%M').zip"
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
