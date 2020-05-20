# myscripts

安装vim-plug插件
```shell
$ curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cp ~/.vimrc ~/.vimrc-bak
cp ./vimrc ~/.vimrc

```
然后打开vim，执行以下操作

```shell
:PlugStatus
:PlugInstall
:PlugUpdate
```

