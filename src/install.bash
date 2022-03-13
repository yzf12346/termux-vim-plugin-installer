#!/bin/bash
# 切换清华源
 sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.bfsu.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list &&sed -i 's@^\(deb.*games stable\)$@#\1\ndeb https://mirrors.bfsu.edu.cn/termux/game-packages-24 games stable@' $PREFIX/etc/apt/sources.list.d/game.list &&sed -i 's@^\(deb.*science stable\)$@#\1\ndeb https://mirrors.bfsu.edu.cn/termux/science-packages-24 science stable@' $PREFIX/etc/apt/sources.list.d/science.list &&apt update -y && apt upgrade -y

# 设置键位
echo "extra-keys = [[{key:'ESC',popup:'\"'},{key:'TAB',popup:'\`'},{key:'CTRL',popup:'ALT'},{key:'SHIFT',popup:'='},{key:'<',popup:'>'},'UP','ENTER'],[{key:'{',popup:'}'},{key:'(',popup:')'},{key:'[',popup:']'},{key:'$',popup:'|'},'LEFT','DOWN','RIGHT']]" >> ~/.termux/termux.properties
termux-reload-settings

# 声明
declare -A PLUG_MAP
declare -A APT_MAP

# 常量
CURRENT_DIR=`cd $(dirname $0);pwd`
PLUG_MAP=(
  ["c"]="coc-clangd"
  ["c++"]="coc-clangd"
  ["typescript"]="coc-tsserver"
  ["javascript"]="coc-tsserver"
  ["python"]="coc-python coc-pyright"
  ["python2"]="coc-python coc-pyright"
  ["web"]="coc-html coc-css coc-html-css-support coc-tsserver coc-htmlhint"
  ["json"]="coc-json"
  ["swift"]="coc-sourcekit"
  ["sql"]="coc-sql"
  ["glsl"]="coc-glslx"
)
APT_MAP=(
  ["typescript"]="npm i typescript -g"
  ["javascript"]="npm i typescript -g"
  ["python"]="apt install python -y"
  ["python2"]="apt install python2 -y"
  ["c++"]="apt install clang -y"
  ["c"]="apt install clang -y"
  )
readonly CURRENT_DIR

# 变量
args=$@
vimPlugs="coc-snippets"
aptList="apt install vim-python -y"

# 复制plug.vim,.vimrc
cd ~
mkdir -p .vim/autoload/
cp ${CURRENT_DIR}/plug.vim -r .vim/autoload/plug.vim
cp ${CURRENT_DIR}/.vimrc -r .vimrc
rm -rf ${CURRENT_DIR}/r.sh
# 安装必备软件
apt install nodejs   # nodejs
npm i yarn -g   # yarn
apt install git -y # git
apt install vim -y # vim
apt install vim-python -y # 支持 coc-snippets

touch ${CURRENT_DIR}/r.sh

# 安装插件
if [[ $1 == "-all" ]];
then
  for key in ${!PLUG_MAP[@]}
  do
    vimPlugs="$vimPlugs ${PLUG_MAP[$key]}"
    if [[ ${APT_MAP[$key]} != "" ]]
    then
      echo ${APT_MAP[$key]} >> $CURRENT_DIR"/r.sh"
    fi
  done
fi

for key in ${!PLUG_MAP[@]}
do
  value=${PLUG_MAP[$key]}
  argvStr=${args[*]}

  if [[ `echo "$argvStr" | grep " $key \|^$key \|^$key$\| $key$"` != "" ]] 
  then
    vimPlugs="$vimPlugs $value"
    if [[ ${APT_MAP[$key]} != "" ]]
    then
      echo ${APT_MAP[$key]} >> $CURRENT_DIR"/r.sh"
    fi
  fi

done
echo "cmd $aptList"

echo "===== PLUGS ===="
echo $vimPlugs
vim -c ":PlugInstall"
sh ${CURRENT_DIR}/r.sh
vim -c ":CocInstall $vimPlugs"
