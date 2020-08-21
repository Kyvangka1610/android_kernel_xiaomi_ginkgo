export KBUILD_BUILD_USER="elang"
export KBUILD_BUILD_HOST="kyvangkaelang"
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_COMPILER_STRING=$(/home/kyvangka1610/kernel/clang-r399163/bin/clang --version | head -n 1 | perl -pe 's/\(http.*?\)//gs' | sed -e 's/  */ /g' -e 's/[[:space:]]*$//')
LD_LIBRARY_PATH=/home/kyvangka1610/kernel/clang-r399163/lib:/home/kyvangka1610/kernel/clang-r399163/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH
PATH=/home/kyvangka1610/kernel/clang-r399163/bin/:$PATH
export PATH
export PROCS=$(nproc --all)
export CROSS_COMPILE=/home/kyvangka1610/kernel/aarch64-linux-android-4.9/bin/aarch64-linux-android-
export CROSS_COMPILE_ARM32=/home/kyvangka1610/kernel/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-
export CC=/home/kyvangka1610/kernel/clang-r399163/bin/clang
export AR=/home/kyvangka1610/kernel/clang-r399163/bin/llvm-ar
export NM=/home/kyvangka1610/kernel/clang-r399163/bin/llvm-nm
export OBJCOPY=/home/kyvangka1610/kernel/clang-r399163/bin/llvm-objcopy
export OBJDUMP=/home/kyvangka1610/kernel/clang-r399163/bin/llvm-objdump
export STRIP=/home/kyvangka1610/kernel/clang-r399163/bin/llvm-strip
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