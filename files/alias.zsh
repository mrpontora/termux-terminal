# Termux
alias all='ls -A'
alias copy='cp -R'
alias move='mv -rf'
alias del='rm -rf'
alias root='cd /data/data/com.termux/files && ls'
alias usr='cd /data/data/com.termux/files/usr && ls'
alias etc='cd /data/data/com.termux/files/usr/etc && ls'
alias bin='cd /data/data/com.termux/files/usr/etc/bin && ls'
alias motd='nano /data/data/com.termux/files/usr/etc/motd'
alias storage='cd ~/storage && ls'
alias shared='cd ~/storage/shared && ls'
alias github='cd ~/storage/shared/GitHub && ls'
alias autoremove='apt autoremove --purge'
alias autoclean='pkg autoclean'
alias x='clear'
alias xx='pkg clean && exit'

# ZSH
alias alias.zsh='nano ~/.oh-my-zsh/custom/alias.zsh'
alias config='nano ~/.zshrc'
alias reload='source ~/.zshrc'
alias plugin='cd ~/.oh-my-zsh/custom/plugins && ls'
alias theme='cd ~/.oh-my-zsh/custom/themes && ls'
alias p10k='nano ~/.p10k.zsh'

# GO BIN
alias gopath='cd ~/go/bin && ls'

# SSH
alias ssh-key='cd ~/.ssh && ls'
alias ssh-list='nano ~/.ssh/config'
alias copy-key='ssh-copy-id'
