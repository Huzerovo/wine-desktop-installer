# Wine桌面安装器

## 这是什么？

这是我的[Wine桌面项目](https://github.com/Huzerovo/wine-desktop)的一个子项目。

这个项目旨在提供一个简单的命令，
在ARM设备上快速安装x86-64版本的[Wine](https://www.winehq.org)，
以及[winetricks](https://github.com/Winetricks/winetricks)。

## 一些说明

安装脚本使用方法：

1. 首先修改`scripts/config.sh`中的相关变量，指定需要安装的Wine版本
2. 运行`bash builder.sh scripts/install.sh wine-desktop-installer`，
   此命令会生成一个安装脚本`wine-desktop-installer`，用于安装Wine。
3. 使用`wine-desktop-installer --help`可以查看相关指令[^installer-help]。

一般来说，初次安装只需使用`wine-desktop-installer`进行全量安装，
你也可以使用选项指定部分安装。

在安装完成后，使用`start-desktop-profile`即可启动Wine。

[^installer-help]: 当前脚本的帮助说明比较简单，请查看源码了解具体脚步做了什么。

## 脚本做了什么？

- 安装非ARM版本的Wine
- 安装Winetricks
- 安装运行所需的依赖
- 安装一个快速启动Wine的命令`start-wine-desktop`

## 注意事项

此脚步**不负责**安装Box64或Box86，你需要手动安装Box64或者Box86。
