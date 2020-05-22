# myscripts

安装vim-plug插件
首先记得备份 vimrc
```shell
cp ~/.vimrc ~/.vimrc-bak
```
执行 install-vimrc.sh

然后打开vim，执行以下操作

```shell
:PlugInstall
:PlugStatus

设置自动刷新，可以输入如下指令：

```shell
:set autoread | au CursorHold * checktime | call feedkeys("lh")
```

