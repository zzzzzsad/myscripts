# myscripts

安装vim-plug插件
首先记得备份 vimrc
```shell
cp ~/.vimrc ~/.vimrc-bak
```
执行 install-vimrc.sh

或下面代码
```shell
$ curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
$ cp ./vimrc ~/.vimrc

```
然后打开vim，执行以下操作

```shell
:PlugInstall
:PlugStatus
```

