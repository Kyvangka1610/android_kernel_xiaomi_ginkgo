export KBUILD_BUILD_USER="elang"
export KBUILD_BUILD_HOST="kyvangkaelang"
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_COMPILER_STRING=$(/home/kyvangka1610/toolchain/clang11/bin/clang --version | head -n 1 | perl -pe 's/\(http.*?\)//gs' | sed -e 's/  */ /g' -e 's/[[:space:]]*$//')
LD_LIBRARY_PATH=/home/kyvangka1610/toolchain/clang11/lib:/home/kyvangka1610/toolchain/clang11/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH
PATH=/home/kyvangka1610/toolchain/clang11/bin/:$PATH
export PATH
export PROCS=$(nproc --all)
export CROSS_COMPILE=/home/kyvangka1610/kernel/aarch64-maestro-linux-gnu/bin/aarch64-maestro-linux-gnu-
export CROSS_COMPILE_ARM32=/home/kyvangka1610/kernel/arm-maestro-linux-gnueabi/bin/arm-maestro-linux-gnueabi-
export CC=/home/kyvangka1610/toolchain/clang11/bin/clang
export AR=/home/kyvangka1610/toolchain/clang11/bin/llvm-ar
export NM=/home/kyvangka1610/toolchain/clang11/bin/llvm-nm
export OBJCOPY=/home/kyvangka1610/toolchain/clang11/bin/llvm-objcopy
export OBJDUMP=/home/kyvangka1610/toolchain/clang11/bin/llvm-objdump
export STRIP=/home/kyvangka1610/toolchain/clang11/bin/llvm-strip
export out=/home/kyvangka1610/out
make O=$out vendor/ginkgo-perf_defconfig
make -j$PROCS O=$out ARCH=arm64 \
	CROSS_COMPILE=$CROSS_COMPILE \
	CROSS_COMPILE_ARM32=$CROSS_COMPILE_ARM32 \
	CC=$CC \
	AR=$AR \
	NM=$NM \
	OBJCOPY=$OBJCOPY \
	OBJDUMP=$OBJDUMP \
	STRIP=$STRIP \
	CLANG_TRIPLE=aarch64-linux-gnu-
