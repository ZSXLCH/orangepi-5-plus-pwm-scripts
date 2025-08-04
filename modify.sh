#!/bin/bash

# 切换到目标目录
cd /root/pwm/linux-orangepi || {
    echo "无法进入目录/root/pwm/linux-orangepi"
    exit 1
}

# 覆盖设备树文件（modify版本）
echo "正在覆盖modify版本设备树文件..."
sudo cp -f /root/pwm/modify/rk3588-orangepi-5-plus.dts arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts || {
    echo "设备树文件覆盖失败"
    exit 1
}

# 编译内核
echo "开始编译内核..."
make -j10 || {
    echo "内核编译失败"
    exit 1
}

# 安装设备树
echo "正在安装设备树..."
sudo make dtbs_install INSTALL_DTBS_PATH=/boot/dtb/ || {
    echo "设备树安装失败"
    exit 1
}

# 重启系统
echo "所有操作完成，即将重启..."
sudo reboot
