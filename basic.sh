#!/bin/bash

# Colors
GREEN='\033[1;32m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
MAGENTA='\033[1;35m'
BLUE='\033[1;34m'
RED='\033[1;31m'
NC='\033[0m'

clear

# Header
echo -e "${MAGENTA}"
echo "╔════════════════════════════════════════════════════╗"
echo "║                Termux Setup Tool                   ║"
echo "║                  Developer: @frn                   ║"
echo "╚════════════════════════════════════════════════════╝"
echo -e "${NC}"

# --all argument support
INSTALL_ALL=false
[[ "$1" == "--all" ]] && INSTALL_ALL=true

# Function: Update Termux
update_termux() {
  echo -e "${CYAN}[+] Updating and Upgrading Termux...${NC}"
  if pkg update -y && pkg upgrade -y; then
    echo -e "${GREEN}✓ Termux updated successfully${NC}"
  else
    echo -e "${RED}✘ Update failed. Please check your internet connection.${NC}"
  fi
}

# Function: Install package groups
install_group() {
  local description="$1"
  shift
  if $INSTALL_ALL; then
    echo -e "${BLUE}[Installing] $description...${NC}"
    pkg install -y "$@"
  else
    read -p "${YELLOW}[?] Install $description? (y/n): ${NC}" choice
    if [[ "$choice" =~ ^[Yy]$ ]]; then
      echo -e "${BLUE}[Installing] $description...${NC}"
      pkg install -y "$@"
    else
      echo -e "${YELLOW}[-] Skipped $description${NC}"
    fi
  fi
}

# Run setup
update_termux

# Essential group installations
install_group "Essential Packages" git curl wget unzip zip tar nano vim neofetch
install_group "Development Tools" clang make cmake build-essential python nodejs
install_group "Network & Security Tools" nmap net-tools tsu dnsutils openssh
install_group "Python Environment" python python-pip

echo -e "${CYAN}[+] Upgrading pip...${NC}"
pip install --upgrade pip

install_group "Linux Utilities" htop tree proot termux-api
install_group "Web Tools" php apache2
install_group "Optional Hacking Tools" hydra sqlmap metasploit
install_group "Fun Tools" toilet cowsay lolcat

# Request storage permission
echo -e "\n${CYAN}[•] Requesting storage permission...${NC}"
termux-setup-storage

# Final message
echo -e "\n${GREEN}[✓] Setup complete. Enjoy your Termux experience, @frn!${NC}"
