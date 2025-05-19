alias ll='ls -l'
alias la='ls -a'

# fzf history
function fzf-select-history() {
    BUFFER=$(history -n -r 1 | fzf --query "$LBUFFER" --reverse)
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N fzf-select-history
bindkey '^r' fzf-select-history

#zplugの読み込み
source ~/.zplug/init.zsh
#zplugをzplug自身で管理
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
#ここに他のプラグインについて設定する
zplug "zsh-users/zsh-autosuggestions", as:plugin
zplug "zsh-users/zsh-syntax-highlighting", as:plugin
zplug "zsh-users/zsh-completions", as:plugin
# 未インストール項目をインストールする
if ! zplug check --verbose; then
    printf "インストールしますか? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
# コマンドをリンクして、PATH に追加し、プラグインは読み込む
zplug load --verbose

export PATH=$HOME/development/flutter/bin:$PATH
export PATH=$PATH:$(go env GOPATH)/bin
export PATH=/opt/homebrew/bin:~/development/flutter/bin:$PATH
export PATH="/opt/homebrew/opt/protobuf@3.20/bin:$PATH"

eval "$(anyenv init -)"
eval "$(direnv hook zsh)"
