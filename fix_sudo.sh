#!/bin/bash

# Colors
GREEN='\033[0;32m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

clear

# Header
echo -e "${CYAN}╔══════════════════════════════════════════════════════╗"
echo -e "${CYAN}║               Termux Root Fix Utility                ║"
echo -e "${CYAN}║              ${YELLOW}Developer: ${CYAN}@frn                          ║"
echo -e "${CYAN}╚══════════════════════════════════════════════════════╝${NC}"
echo

# Step 1: Remove tsu
echo -e "${YELLOW}➤ Step 1: Removing conflicting 'tsu' package...${NC}"
if pkg uninstall tsu -y > /dev/null 2>&1; then
    echo -e "${GREEN}✔ 'tsu' removed successfully${NC}"
else
    echo -e "${RED}✘ Failed to remove 'tsu' or it's not installed${NC}"
fi

# Step 2: Update & upgrade
echo -e "${YELLOW}➤ Step 2: Updating and upgrading packages...${NC}"
if pkg update -y > /dev/null 2>&1 && pkg upgrade -y > /dev/null 2>&1; then
    echo -e "${GREEN}✔ Packages updated successfully${NC}"
else
    echo -e "${RED}✘ Failed to update packages${NC}"
fi

# Step 3: Install sudo
echo -e "${YELLOW}➤ Step 3: Installing 'sudo' package...${NC}"
if pkg install sudo -y > /dev/null 2>&1; then
    echo -e "${GREEN}✔ 'sudo' installed successfully${NC}"
else
    echo -e "${RED}✘ Failed to install 'sudo'${NC}"
fi

# Step 4: Test sudo
echo -e "${YELLOW}➤ Step 4: Retesting root access using 'sudo su'...${NC}"
echo -e "${CYAN}══════════════════════════════════════════════════════${NC}"
echo -e "${CYAN}Note:${NC} If you see a root prompt (#), root access is working."
echo -e "${CYAN}══════════════════════════════════════════════════════${NC}"
sleep 2
sudo su
