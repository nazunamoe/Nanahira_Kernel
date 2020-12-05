#/bin/sh

make O=out ARCH=arm64 vendor/nanahira_defconfig

export ARCH=arm64
export SUBARCH=arm64
export DTC_EXT=dtc

PATH="/home/nazunamoe/proton-clang/bin:${PATH}" \
# PATH="/home/nazunamoe/clang/bin:/home/nazunamoe/aarch64-linux-android-4.9/bin:/home/nazunamoe/arm-linux-androideabi-4.9/bin:${PATH}" \

#make -j$(nproc --all) O=out \
#			ARCH=arm64 \
#			CC=clang \
#			AR=llvm-ar \
#			NM=llvm-nm \
#			OBJCOPY=llvm-objcopy \
#			OBJDUMP=llvm-objdump \
#			STRIP=llvm-strip \
#			CROSS_COMPILE=aarch64-linux-gnu- \
#			CROSS_COMPILE_ARM32=arm-linux-gnueabi-

make -j$(nproc --all) O=out \
			ARCH=arm64 \
			CC=clang \
			CLANG_TRIPLE=aarch64-linux-gnu- \
			CROSS_COMPILE=aarch64-linux-android- \
			CROSS_COMPILE_ARM32=arm-linux-androideabi-
                     
rm -f /home/nazunamoe/anykernel2/*.zip
rm -f /home/nazunamoe/anykernel2/*.gz-dtb
rm -f /home/nazunamoe/anykernel2/*.dtbo

cp out/arch/arm64/boot/Image.gz-dtb /home/nazunamoe/anykernel2/Image.gz-dtb

python /home/nazunamoe/lib/src/mkdtboimg.py create /home/nazunamoe/anykernel2/dtbo.img /home/nazunamoe/kernel_temp/out/arch/arm64/boot/dts/qcom/*.dtbo

cd /home/nazunamoe/anykernel2

FORMAT="%Y%m%d-%H%M"
_DATE=$(date +"$FORMAT" )

zip -r "Nanahira_Kernel_${_DATE}.zip" * --exclude *.zip
cd /home/nazunamoe/kernel_temp
