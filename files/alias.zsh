# Termux
alias all='ls -A'
alias copy='cp -rfi'
alias move='mv -rf'
alias del='rm -rf'
alias usr='cd /data/data/com.termux/files/usr && ls'
alias etc='cd /data/data/com.termux/files/usr/etc && ls'
alias motd='nano /data/data/com.termux/files/usr/etc/motd'
alias storage='cd ~/storage && ls'
alias shared='cd ~/storage/shared && ls'
alias update='pkg update -y && apt update'
alias upgrade='pkg upgrade -y && apt upgrade -y'
alias list='apt list --upgradable'
alias purge='apt autoremove --purge'
alias clean='pkg autoclean'
alias x='clear'
alias xx='pkg clean && exit'

# ZSH
alias alias.zsh='nano ~/.oh-my-zsh/custom/alias.zsh'
alias config='nano ~/.zshrc'
alias reload='exec zsh'
alias plugin='cd ~/.oh-my-zsh/custom/plugins && ls'
alias theme='cd ~/.oh-my-zsh/custom/themes && ls'
alias p10k.zsh='nano ~/.p10k.zsh'

# GO BIN
alias bin='cd ~/go/bin && ls'

# SSH
alias ssh-list='nano ~/.ssh/config'
alias ssh-key='ssh-copy-id'
