echo -e "\nStarting compilation...\n"
# ENV
CONFIG=vendor/sixteen_defconfig
KERNEL_DIR=$(pwd)
PARENT_DIR="$(dirname "$KERNEL_DIR")"
KERN_IMG="$KERNEL_DIR/out/arch/arm64/boot/Image.gz-dtb"
export KBUILD_BUILD_USER="elang"
export KBUILD_BUILD_HOST="kyvangkaelang"
export PATH="/home/kyvangka1610/toolchain/clang-r407598b/bin:$PATH"
export LD_LIBRARY_PATH="/home/kyvangka1610/toolchain/clang-r407598b/lib:$LD_LIBRARY_PATH"
export KBUILD_COMPILER_STRING="$(/home/kyvangka1610/toolchain/clang-r407598b/bin/clang --version | head -n 1 | perl -pe 's/\((?:http|git).*?\)//gs' | sed -e 's/  */ /g' -e 's/[[:space:]]*$//' -e 's/^.*clang/clang/')"
export out=/home/kyvangka1610/out-new-Q

# Functions
clang_build () {
    make -j4 O=$out \
                          ARCH=arm64 \
                          CC="clang" \
                          AR="llvm-ar" \
                          NM="llvm-nm" \
						  LD="ld.lld" \
			              AS="llvm-as" \
			              OBJCOPY="llvm-objcopy" \
			              OBJDUMP="llvm-objdump" \
                          CLANG_TRIPLE=aarch64-linux-gnu- \
                          CROSS_COMPILE="/home/kyvangka1610/toolchain/gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-" \
                          CROSS_COMPILE_ARM32="/home/kyvangka1610/toolchain/gcc-arm-10.2-2020.11-x86_64-arm-none-linux-gnueabihf/bin/arm-none-linux-gnueabihf-"
}

# Build kernel
make O=$out ARCH=arm64 $CONFIG > /dev/null
echo -e "${bold}Compiling with CLANG${normal}\n$KBUILD_COMPILER_STRING"
clang_build
echo -e "\nCompleted in $((SECONDS / 60)) minute(s) and $((SECONDS % 60)) second(s) !"
