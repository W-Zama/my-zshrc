
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

alias ll='ls -l'

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

eval "$(rbenv init -)"

export PATH=$PATH:$(go env GOPATH)/bin