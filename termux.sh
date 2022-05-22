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
echo -e "${INFO} ${Y}Install root-repo & x11-repo${N}"
echo -e ""
sleep 1
pkg install root-repo -y
pkg install x11-repo -y
pkg install termux-api -y
termux-change-repo
clear
echo -e "${INFO} ${Y}Install package update${N}"
echo -e ""
sleep 1
apt list --upgradable
pkg upgrade -y
clear
echo -e "${INFO} ${Y}Configuring termux.properties${N}"
sleep 1
if [[ -f ~/.termux/termux.properties ]]; then
sed -i 's+# allow-external-apps = true+allow-external-apps = true+g' ~/.termux/termux.properties
sed -i 's+# terminal-cursor-style = block+terminal-cursor-style = bar+g' ~/.termux/termux.properties
fi

# Install Package
gitinfo=$(git --version)
zshinfo=$(zsh --version)
goinfo=$(go version)
pythoninfo=$(python --version)
pipinfo=$(pip --version)
sslinfo=$(openssl version)
shellinfo=$(shellcheck --version)
shfmtinfo=$(shfmt --version)
egetinfo=$(eget --version)
microinfo=$(micro --version)
echo -e "${INFO} ${Y}Installing initial package${N}"
echo -e ""
sleep 1
pkg install curl wget git zip unzip tar zsh golang python openssh openssl-tool shellcheck -y
go install mvdan.cc/sh/v3/cmd/shfmt@latest
go install github.com/zyedidia/eget@latest
echo -e "5" | eget zyedidia/micro
clear
echo -e "${OK} ${Y}Initial package installed:${N}"
sleep 1
echo -e "${OK} ${B}$gitinfo${N}"
echo -e "${OK} ${B}$zshinfo${N}"
echo -e "${OK} ${B}$goinfo${N}"
echo -e "${OK} ${B}$pythoninfo${N}"
echo -e "${OK} ${B}$pipinfo${N}"
echo -e "${OK} ${B}$sslinfo${N}"
echo -e "${OK} ${B}$shellinfo${N}"
echo -e "${OK} ${B}$shfmtinfo${N}"
echo -e "${OK} ${B}$egetinfo${N}"
echo -e "${OK} ${B}$microinfo${N}"
echo -e ""
echo -e "${INFO} ${Y}Installing pip package${N}"
sleep 1
python -m pip install --upgrade pip
pip install lolcat
pip install Pygments
echo -e ""
echo -e "${OK} ${Y}Pip package installed${N}"
sleep 1
lolcatinfo=$(pip list | grep 'lolcat')
pygmentsinfo=$(pip list | grep 'Pygments')
echo -e "${OK} ${B}$lolcatinfo${N}"
echo -e "${OK} ${B}$pygmentsinfo${N}"
echo -e ""
sleep 1
echo -e "${INFO} ${Y}Setup ssh-key${N}"
sleep 1
ssh-keygen -b 4096 -t rsa
if [[ -d ~/.ssh ]]; then
touch ~/.ssh/config
fi
clear

# Setup MOTD
echo -e "${INFO} ${Y}Setup motd file${N}"
sleep 1
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

# Install Oh-My-Zsh
echo -e ""
echo -e "${INFO} ${R}This script will be auto exit after oh-my-zsh successful installed for the first time${N}"
echo -e "${INFO} ${R}Enter ./termux.sh to continue setup oh-my-zsh completely"
sleep 3
echo -e ""
echo -e "${INFO} ${Y}Installing oh-my-zsh${N}"
sleep 1
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
./termux.sh
}

setup_ohmyzsh() {
echo -e "${INFO} ${Y}Installing oh-my-zsh plugin${N}"
sleep 1
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
clear
echo -e "${INFO} ${Y}Installing oh-my-zsh theme${N}"
sleep 1
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
clear
echo -e "${INFO} ${Y}Configuring .zshrc file${N}"
sleep 1
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
clear

# Check Update
echo -e "${INFO} ${Y}Installing package update${N}"
sleep 1
apt list --upgradable
pkg upgrade -y
apt autoremove --purge -y
if [[ -f ~/.p10k.zsh ]]; then
rm -r ~/.p10k.zsh
wget https://raw.githubusercontent.com/pontora/termux-terminal/main/files/.p10k.zsh
else
wget https://raw.githubusercontent.com/pontora/termux-terminal/main/files/.p10k.zsh
fi
clear
echo -e "${OK} ${Y}Termux setup is completed${N}"
echo -e "${OK} ${Y}oh-my-zsh install is completed${N}"
echo -e ""
echo -e "${INFO} ${Y}Enter to exit..${N} \c"
read option
case $option in
*) pkg autoclean
   pkg clean
   clear
   exit
   ;;
esac
}

if [[ -f /data/data/com.termux/files/usr/bin/zsh ]]; then
clear
setup_ohmyzsh
else
clear
install_ohmyzsh
fi
