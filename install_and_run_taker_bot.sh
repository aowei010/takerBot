#!/bin/bash

# 检查是否安装了 nvm
if ! command -v nvm &> /dev/null
then
    echo "nvm 未安装. 安装 nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
else
    echo "nvm 已安装"
fi

# 使用 nvm 安装并使用特定版本的 Node.js
nvm install 18
nvm use 18

# 克隆仓库
if [ ! -d "takerBot" ]; then
    echo "克隆仓库..."
    git clone https://github.com/aowei010/takerBot.git
else
    echo "仓库已存在"
fi

cd takerBot

# 安装依赖项
echo "安装依赖项..."
npm install

# 加载环境变量
if [ -f .env ]; then
    echo "加载环境变量..."
    export $(grep -v '^#' .env | xargs)
else
    echo ".env 文件不存在，请创建并添加钱包信息。"
    exit 1
fi

# 提示用户手动运行脚本
echo "安装已完成。请手动运行以下命令以启动脚本："
echo "cd $(pwd) && npm run start"
