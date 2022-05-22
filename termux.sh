#!/bin/bash

# Color
N="\033[0m"
R="\033[31m"
G="\033[32m"
B="\033[34m"
Y="\033[33m"
C='\033[36m'
M='\033[35m'
LR="\033[1;31m"
LG="\033[1;32m"
LB="\033[1;34m"
LY="\033[1;33m"
LC='\033[1;36m'
LM='\033[1;35m'
RB="\033[41;37m"
GB="\033[42;37m"
BB="\033[44;37m"

# Notification
OK="${G}[✓]${N}"
ERROR="${R}[!]${N}"
INFO="${C}[i]${N}"
PLUS="${Y}[+]${N}"

install_ohmyzsh() {
# Setup Repo
echo -e "${INFO} ${G}Install root-repo & x11-repo ...${N}"
echo -e ""
sleep 2
pkg install root-repo -y
pkg install x11-repo -y
pkg install termux-api -y
termux-change-repo
echo -e ""
echo -e "${OK} ${B}Repo installed!${N}"
sleep 3
clear
echo -e "${INFO} ${G}Configuring termux.properties ...${N}"
sleep 2
if [[ -f ~/.termux/termux.properties ]]; then
sed -i 's+# allow-external-apps = true+allow-external-apps = true+g' ~/.termux/termux.properties
sed -i 's+# terminal-cursor-style = block+terminal-cursor-style = bar+g' ~/.termux/termux.properties
fi
sleep 3
# Install Package
echo -e "${INFO} ${G}Installing initial package ...${N}"
echo -e ""
sleep 2
pkg install curl wget git zip unzip tar zsh golang python openssh openssl-tool shellcheck -y
echo -e ""
echo -e "${OK} ${B}Initial package installed!${N}"
sleep 3
clear
echo -e "${INFO} ${G}Installing go package ...${N}"
echo -e ""
sleep 2
go install mvdan.cc/sh/v3/cmd/shfmt@latest
go install github.com/zyedidia/eget@latest
echo -e "5" | eget zyedidia/micro
echo -e ""
echo -e "${OK} ${B}Go package installed!${N}"
sleep 3
clear
echo -e "${INFO} ${G}Installing pip package ...${N}"
echo -e ""
sleep 2
python -m pip install --upgrade pip
pip install lolcat
pip install Pygments
echo -e ""
echo -e "${OK} ${B}Pip package installed!${N}"
sleep 3
echo -e "${INFO} ${G}Setup ssh-key ...${N}"
echo -e ""
sleep 2
ssh-keygen -b 4096 -t rsa
if [[ -d ~/.ssh ]]; then
touch ~/.ssh/config
fi
sleep 3
clear

# Setup MOTD
echo -e "${INFO} ${G}Setup MOTD file ...${N}"
echo -e ""
sleep 2
rm -r /data/data/com.termux/files/usr/etc/motd
cd /data/data/com.termux/files/usr/etc
wget https://raw.githubusercontent.com/pontora/termux-terminal/main/files/motd
cd
git clone https://github.com/Generator/termux-motd.git ~/.motd
if [[ -f /data/data/com.termux/files/usr/etc/profile ]]; then
echo "$HOME/.motd/init.sh" >> /data/data/com.termux/files/usr/etc/profile
else
touch /data/data/com.termux/files/usr/etc/profile
echo "$HOME/.motd/init.sh" >> /data/data/com.termux/files/usr/etc/profile
fi
cd ~/.motd
rm -r ~/.motd/10-android-logo
rm -r ~/.motd/10-android-logo-small.disabled
rm -r ~/.motd/20-sysinfo
rm -r ~/.motd/20-uptime
rm -r ~/.motd/25-andoid-temp
rm -r ~/.motd/35-diskspace
rm -r ~/.motd/10-termux-banner.disabled
wget https://raw.githubusercontent.com/pontora/termux-terminal/main/files/10-termux-banner
cd
echo -e ""
echo -e "${OK} ${B}MOTD file setup successful!${N}"
sleep 3

# Install Oh-My-Zsh
echo -e ""
echo -e "${INFO} ${G}Enter ./termux.sh to continue setup oh-my-zsh after exit and reopen Termux ...${N}"
sleep 2
echo -e "${INFO} ${G}Installing oh-my-zsh ...${N}"
echo -e ""
sleep 2
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

setup_ohmyzsh() {
echo -e "${OK} ${B}Oh-my-zsh installed!${N}"
sleep 3
echo -e "${INFO} ${G}Installing oh-my-zsh plugin ...${N}"
echo -e ""
sleep 2
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
echo -e ""
echo -e "${OK} ${B}Plugin installed!${N}"
sleep 3
echo -e "${INFO} ${G}Installing oh-my-zsh theme ...${N}"
echo -e ""
sleep 2
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
echo -e ""
echo -e "${OK} ${B}Theme installed!${N}"
sleep 3
clear
echo -e "${INFO} ${G}Setup .zshrc file ...${N}"
echo -e ""
sleep 2
sed -i 's+ZSH_THEME="robbyrussell"+ZSH_THEME="powerlevel10k/powerlevel10k"+g' ~/.zshrc
sed -i 's+plugins=(git)+plugins=(colorize copyfile copypath fast-syntax-highlighting history magic-enter safe-paste transfer zsh-autosuggestions)+g' ~/.zshrc
cd ~/.oh-my-zsh/custom
wget https://raw.githubusercontent.com/pontora/termux-terminal/main/files/alias.zsh
cd
if [[ -f /data/data/com.termux/files/usr/etc/zshrc ]]; then
echo -e "" >> /data/data/com.termux/files/usr/etc/zshrc
echo -e "# GOPATH" >> /data/data/com.termux/files/usr/etc/zshrc
echo -e "export PATH=$PATH:$HOME/go/bin" >> /data/data/com.termux/files/usr/etc/zshrc
else
touch /data/data/com.termux/files/usr/etc/zshrc
echo -e "" >> /data/data/com.termux/files/usr/etc/zshrc
echo -e "# GOPATH" >> /data/data/com.termux/files/usr/etc/zshrc
echo -e "export PATH=$PATH:$HOME/go/bin" >> /data/data/com.termux/files/usr/etc/zshrc
fi
cd /go/bin
wget https://raw.githubusercontent.com/pontora/termux-terminal/main/files/add-host
cd
echo -e ""
echo -e "${OK} ${B}.zshrc file setup successful!${N}"
sleep 3
clear

# Final Setup
echo -e "${INFO} ${G}Finishing Termux setup ...${N}"
echo -e ""
sleep 2
if [[ -f ~/.p10k.zsh ]]; then
rm -r ~/.p10k.zsh
wget https://raw.githubusercontent.com/pontora/termux-terminal/main/files/.p10k.zsh
else
wget https://raw.githubusercontent.com/pontora/termux-terminal/main/files/.p10k.zsh
fi
echo -e ""
echo -e "${OK} ${B}Termux setup completed!${N}"
echo -e "${OK} ${B}oh-my-zsh install completed!${N}"
echo -e ""
echo -e "${INFO} ${G}Press enter to exit ...${N} \c"
read option
case $option in
*) pkg autoclean
   pkg clean
   clear
   exit
   ;;
esac
}

clear
check=$(whereis zsh | awk '{print $2}')
if [[ $check == "/data/data/com.termux/files/usr/bin/zsh" ]]; then
clear
setup_ohmyzsh
else
echo -e "${INFO} ${G}Please do not close or exit the app while script start to avoid error ...${N}"
echo -e "${INFO} ${G}Press Ctrl+C to force stop the script ...${N}"
echo -e ""
echo -e "${G}Confirm to start (y/n)?${N} \c"
read reply
case $reply in
y) clear
   install_ohmyzsh
   ;;
n) exit
   ;;
esac
fi
