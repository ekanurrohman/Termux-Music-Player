#!/bin/bash

# Colors
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
CYAN="\033[36m"
RESET="\033[0m"

# Paths
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
MPD_CONF_SRC="$SCRIPT_DIR/mpd.conf"
CAVA_CONF_SRC="$SCRIPT_DIR/cava.conf"
MPD_CONF_DST="$PREFIX/etc/mpd.conf"
CAVA_CONF_DST="$HOME/.config/cava/config"
BACKUP_DIR="$SCRIPT_DIR/backups"

# Make sure backup dir exists
mkdir -p "$BACKUP_DIR"

# Banner
echo -e "${CYAN}"
echo "╔═══════════════════════════════╗"
echo "║      Termux MPD Installer     ║"
echo "╚═══════════════════════════════╝"
echo -e "${RESET}"

echo "1) Install MPD + Ncmpcpp + Pulseaudio + Cava"
echo "2) Restore MPD config"
echo "3) Restore Cava config"
read -p "Choose an option: " choice

case $choice in
    1)
        echo -e "${YELLOW}Warning: This will overwrite your mpd.conf & cava.conf!${RESET}"
        read -p "Proceed? (y/n): " confirm
        if [ "$confirm" != "y" ]; then
            echo -e "${RED}Aborted.${RESET}"
            exit 1
        fi

        echo -e "${GREEN}>> Installing packages...${RESET}"
        pkg update -y && pkg upgrade -y
        pkg install -y mpd ncmpcpp pulseaudio tmux cava

        echo -e "${GREEN}>> Backing up old configs...${RESET}"
        [ -f "$MPD_CONF_DST" ] && cp "$MPD_CONF_DST" "$BACKUP_DIR/mpd.conf.bak"
        [ -f "$CAVA_CONF_DST" ] && cp "$CAVA_CONF_DST" "$BACKUP_DIR/cava.conf.bak"

        echo -e "${GREEN}>> Deploying new configs...${RESET}"
        cp "$MPD_CONF_SRC" "$MPD_CONF_DST"
        mkdir -p "$(dirname "$CAVA_CONF_DST")"
        cp "$CAVA_CONF_SRC" "$CAVA_CONF_DST"

        echo -e "${GREEN}>> Starting services...${RESET}"
        pulseaudio --start
        mpd

        echo -e "${CYAN}Setup complete! Run 'ncmpcpp' or 'cava' to start.${RESET}"
        ;;
    2)
        if [ -f "$BACKUP_DIR/mpd.conf.bak" ]; then
            cp "$BACKUP_DIR/mpd.conf.bak" "$MPD_CONF_DST"
            echo -e "${GREEN}MPD config restored.${RESET}"
        else
            echo -e "${RED}No MPD backup found.${RESET}"
        fi
        ;;
    3)
        if [ -f "$BACKUP_DIR/cava.conf.bak" ]; then
            cp "$BACKUP_DIR/cava.conf.bak" "$CAVA_CONF_DST"
            echo -e "${GREEN}Cava config restored.${RESET}"
        else
            echo -e "${RED}No Cava backup found.${RESET}"
        fi
        ;;
    *)
        echo -e "${RED}Invalid option.${RESET}"
        ;;
esac