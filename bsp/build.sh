make distclean
echo -e "\033[32m #### start build kernel #### \033[0m"
make_config
cp -f myconfig out/ud710_7h10/obj/kernel/.config
cp -f myconfig out/ud710_7h10/obj/kernel/.config.old
make_headers
make_dtb
mkdir $BSP_KERNEL_OUT -p
command make -C $BSP_KERNEL_PATH O=$BSP_KERNEL_OUT $BSP_MAKE_EXTRA_ARGS ARCH=$BSP_BOARD_ARCH CROSS_COMPILE=$BSP_KERNEL_CROSS_COMPILE -j$BSP_OBJ
mkdir $BSP_KERNEL_DIST -p
find $BSP_KERNEL_OUT -name $BSP_DTB.dtb | xargs -i cp {} $BSP_KERNEL_DIST
find $BSP_KERNEL_OUT -name $BSP_DTBO.dtbo | xargs -i cp {} $BSP_KERNEL_DIST
cd $BSP_KERNEL_OUT
command make -C $BSP_KERNEL_OUT O=$BSP_KERNEL_OUT $BSP_MAKE_EXTRA_ARGS ARCH=$BSP_BOARD_ARCH INSTALL_MOD_PATH=$BSP_KERNEL_DIST modules_install -j$BSP_OBJ
cd $BSP_ROOT_DIR
cp -f $BSP_KERNEL_OUT/vmlinux $BSP_KERNEL_DIST
find $BSP_KERNEL_OUT -name Image | xargs -i cp {} $BSP_KERNEL_DIST
find $BSP_KERNEL_OUT -name System.map | xargs -i cp {} $BSP_KERNEL_DIST
find $BSP_KERNEL_OUT -name .config | xargs -i cp {} $BSP_KERNEL_DIST
find $BSP_KERNEL_OUT -name .dtb | xargs -i cp {} $BSP_KERNEL_DIST
find $BSP_KERNEL_OUT -name .dtbo | xargs -i cp {} $BSP_KERNEL_DIST
make_modules

