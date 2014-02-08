#export LC_ALL=ja_JP.UTF-8
# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _correct _approximate
zstyle ':completion:*' max-errors 10
# コマンドにsudoを付けてもきちんと補完出来るようにする
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                                           /usr/sbin /usr/bin /sbin /bin
# 大文字/小文字を区別しないで補完できるようにするが、大文字を入力した場合は区別する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 補完候補を矢印キーなどで選択できるようにする
zstyle ':completion:*:default' menu select
# 補完候補をhjklで選択可能に
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey '^R' zaw-history

# 補完機能の強化
autoload -U compinit
compinit

# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
# End of lines configured by zsh-newuser-install

## コアダンプサイズを制限
limit coredumpsize 102400
## 出力の文字列末尾に改行コードが無い場合でも表示
unsetopt promptcr
## viライクキーバインド設定
bindkey -v

## 色を使う
setopt prompt_subst
## ビープを鳴らさない
setopt nobeep
## 内部コマンドjobsの出力をデフォルトでjobs -lにする
setopt long_list_jobs
## 補完候補一覧でファイルの種別をマーク表示
setopt list_types


## サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt auto_resume
## 補完候補を一覧表示
setopt auto_list
## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups
## cd 時に自動でpush
setopt auto_pushd
## 同じディレクトリをpushdしない
setopt pushd_ignore_dups
## ファイル名で #,~,^の3文字を正規表現として扱う
setopt extended_glob
## TABで順に補完候補を切り替える
setopt auto_menu
## zshの開始/終了時刻をヒストリファイルに書き込む
setopt extended_history
## =command を comman のパス名に展開する
setopt equals
## --prefix=/usr などの = 以降も補完
setopt magic_equal_subst
## ヒストリを呼び出してから実行する間に一旦編集
setopt hist_verify
## ファイル名の展開で辞書順ではなく数値的にソート
setopt numeric_glob_sort
## 出力時8ビットを通す
setopt print_eight_bit
## ヒストリを共有
setopt share_history
## 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1
## 補完候補の色づけ
# eval `dircolors`
export ZLS_COLORS=$LS_COLORS
# 補完候補もLS_COLORSに従って色つけ
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
## ディレクトリ名だけで cd
setopt auto_cd
## ディレクトリ移動時に存在しないディレクトリを指定した場合、それがスラッシュで始まらない単語であれば、単語の前に~を補って名前付きディレクトリへの移動を試みる
setopt cdable_vars
## 括弧の対応などを自動的に補完
setopt auto_param_keys
## ディレクトリ名の候補で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash
## スペルチェック
setopt correct
## {a-c}を a b cに展開する機能を使える様にする
setopt brace_ccl
## Ctrl+S/Ctrl+Q によるフロー制御を使わない様にする
setopt NO_flow_control
## コマンドラインの先頭がspaceで始まる場合ヒストリに追加しない
setopt hist_ignore_space
## コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments
## ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt mark_dirs
## history (fc -l) コマンドをヒストリリストから取り除く
setopt hist_no_store
## 補完候補を詰めて表示
setopt list_packed
## 最後のスラッシュを自動的に削除しない
setopt noautoremoveslash
## コピペしたときに右端のプロンプトを消してくれる
setopt transient_rprompt


## history
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
## ヒストリ補完(backward)
bindkey "^P" history-beginning-search-backward-end
## ヒストリ補完(forward)
bindkey "^N" history-beginning-search-forward-end
## ヒストリのインクリメンタルサーチ
#bindkey "^R" history-incremental-pattern-search-backward
bindkey "^R" history-incremental-search-backward
#bindkey "^S" history-incremental-pattern-search-forward
function history-all { history -E 1 }
function history-today { history-all | grep `date +"%-d.%-m.%Y"` | less }
function history-today-count { history-all | grep `date +"%-d.%-m.%Y"` | wc -l }

# command line stack
bindkey -a 'q' push-line

## predict
autoload predict-on
zle -N predict-on
zle -N predict-off
bindkey '^xp' predict-on
bindkey '^x^p' predict-off

## prompt
# VCSの情報を取得するzshの便利関数 vcs_infoを使う
autoload -Uz vcs_info

# 表示フォーマットの指定
# %b ブランチ情報
# %a アクション名(mergeなど)
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

# バージョン管理されているディレクトリにいれば表示，そうでなければ非表示
RPROMPT="%1(v|%F{green}%1v%f|)%~"
