export KBUILD_BUILD_USER="elang"
export KBUILD_BUILD_HOST="kyvangkaelang"
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_COMPILER_STRING=$(/home/kyvangka1610/toolchain/clang-r377782d/bin/clang --version | head -n 1 | perl -pe 's/\(http.*?\)//gs' | sed -e 's/  */ /g' -e 's/[[:space:]]*$//')
LD_LIBRARY_PATH=/home/kyvangka1610/toolchain/clang-r377782d/lib:/home/kyvangka1610/toolchain/clang-r377782d/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH
PATH=/home/kyvangka1610/toolchain/clang-r377782d/bin/:$PATH
export PATH
export PROCS=$(nproc --all)
export CROSS_COMPILE=/home/kyvangka1610/toolchain/aarch64-linux-android-4.9/bin/aarch64-linux-android-
export CROSS_COMPILE_ARM32=/home/kyvangka1610/toolchain/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-
export CC=/home/kyvangka1610/toolchain/clang-r377782d/bin/clang
export AR=/home/kyvangka1610/toolchain/clang-r377782d/bin/llvm-ar
export NM=/home/kyvangka1610/toolchain/clang-r377782d/bin/llvm-nm
export OBJCOPY=/home/kyvangka1610/toolchain/clang-r377782d/bin/llvm-objcopy
export OBJDUMP=/home/kyvangka1610/toolchain/clang-r377782d/bin/llvm-objdump
export STRIP=/home/kyvangka1610/toolchain/clang-r377782d/bin/llvm-strip
export out=/home/kyvangka1610/out-new-R
make O=$out vendor/sixteen_defconfig
make -j$PROCS O=$out ARCH=arm64 \
	CROSS_COMPILE=$CROSS_COMPILE \
	CROSS_COMPILE_ARM32=$CROSS_COMPILE_ARM32 \
	CC=$CC \
	NM=$NM \
	LD=$LD \
	OBJCOPY=$OBJCOPY \
	OBJDUMP=$OBJDUMP \
	STRIP=$STRIP \
	CLANG_TRIPLE=aarch64-linux-gnu-
