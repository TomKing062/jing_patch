source build/envsetup.sh
lunch
make_config
#cp -f myconfig out/ud710_7h10/obj/kernel/.config
make_headers
mkdir $BSP_KERNEL_OUT -p
command make -C $BSP_KERNEL_PATH O=$BSP_KERNEL_OUT $BSP_MAKE_EXTRA_ARGS ARCH=$BSP_BOARD_ARCH CROSS_COMPILE=$BSP_KERNEL_CROSS_COMPILE -j$BSP_OBJ
cd $BSP_KERNEL_OUT
command make -C $BSP_KERNEL_OUT O=$BSP_KERNEL_OUT $BSP_MAKE_EXTRA_ARGS ARCH=$BSP_BOARD_ARCH INSTALL_MOD_PATH=$BSP_KERNEL_DIST modules_install -j$BSP_OBJ
cd $BSP_ROOT_DIR
for BSP_KERNEL_BIN in $BSP_KERNEL_FILE_LIST;
do
	if [[ $BSP_KERNEL_BIN == "vmlinux" ]]; then
		cp -f $BSP_KERNEL_OUT/vmlinux $BSP_KERNEL_DIST
	else
		find $BSP_KERNEL_OUT -name $BSP_KERNEL_BIN | xargs -i cp {} $BSP_KERNEL_DIST
	fi
done
