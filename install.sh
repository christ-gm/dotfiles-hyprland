#!/bin/bash

# Colores para mensajes
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
CYAN='\e[1;36m'
NC='\e[0m' # No Color

# Función para instalar paquetes base
function install_base_packages() {
    echo -e "${BLUE}Instalando paquetes base...${NC}"
    sudo pacman -S --needed --noconfirm \
        waybar \
        pavucontrol \
        curl \
        tar \
        bluez bluez-utils blueman \
        noto-fonts noto-fonts-cjk noto-fonts-emoji \
        git base-devel
    
    if [ $? -ne 0 ]; then
        echo -e "${RED}Error al instalar paquetes base${NC}"
        exit 1
    fi
}


# Función para instalar yay
function install_yay() {
    if ! command -v yay &> /dev/null; then
        echo -e "${BLUE}Instalando yay...${NC}"
        git clone https://aur.archlinux.org/yay.git /tmp/yay-bin
        cd /tmp/yay-bin || exit
        makepkg -si --noconfirm
        cd ~ || exit
        
        if ! command -v yay &> /dev/null; then
            echo -e "${RED}Error al instalar yay${NC}"
            exit 1
        fi
    fi
}

# Función para instalar paquetes AUR
function install_aur_packages() {
    echo -e "${BLUE}Instalando Paquetes AUR...${NC}"
    yay -S --noconfirm \
        ttf-nerd-fonts-symbols \
        ttf-jetbrains-mono-nerd \
        ttf-3270-nerd \
        wlogout \
        wayland-logout \
        swaylock
    
    fc-cache -fv
}

# Función para habilitar servicios
function enable_services() {
    echo -e "${BLUE}Habilitando Bluetooth...${NC}"
    sudo systemctl enable --now bluetooth
    
    if [ $? -ne 0 ]; then
        echo -e "${YELLOW}Advertencia: No se pudo habilitar Bluetooth${NC}"
    fi

    echo -e "${BLUE}Habilitando NetworkManager...${NC}"
    sudo systemctl enable --now NetworkManager

    if [ $? -ne 0 ]; then
        echo -e "${YELLOW}Advertencia: No se pudo habilitar NetworkManager${NC}"
    fi
}

# Copiar dotfiles
function copy_dotfiles() {
    echo -e "${BLUE}Copiando Configuraciones...${NC}"
    sleep 0.5
    
    mkdir -p ~/.config ~/.local/bin ~/.local/share/fonts
    cp -r config/* "$HOME/.config/" || echo -e "${YELLOW}Advertencia: Error al copiar configuraciones${NC}"
    cp -r scripts/* "$HOME/.local/bin" || echo -e "${YELLOW}Advertencia: Error al copiar scripts${NC}"
}

# Configurar SDDM sin contraseña
function configure_sddm_nopass() {
    echo -e "${BLUE}Configurando reinicio sin contraseña para SDDM...${NC}"
    
    local SUDOERS_FILE="/etc/sudoers.d/sddm_restart"
    local USERNAME=$(whoami)
    
    if [ ! -f "$SUDOERS_FILE" ]; then
        echo "$USERNAME ALL=(root) NOPASSWD: /usr/bin/systemctl restart sddm" | sudo tee "$SUDOERS_FILE" >/dev/null
        sudo chmod 440 "$SUDOERS_FILE"
        
        if sudo visudo -cf "$SUDOERS_FILE"; then
            echo -e "${GREEN}Configuración de SDDM completada${NC}"
        else
            echo -e "${RED}Error en la configuración de sudoers${NC}"
            sudo rm -f "$SUDOERS_FILE"
        fi
    else
        echo -e "${YELLOW}La configuración de SDDM ya existe${NC}"
    fi
}

# Instalar Fuentes
function install_fonts(){
    local FONTS=("FiraCode" "CascadiaCode" "Hack" "JetBrainsMono" "3270" "NerdFontsSymbolsOnly")
    local DIR_FONTS="$HOME/.local/share/fonts"
    local DIR_DOWNLOADS="/tmp/fonts_tmp"
    mkdir -p "$DIR_DOWNLOADS"

    if ! command -v curl &>/dev/null || ! command -v tar &>/dev/null; then
        echo -e "${RED}Error: curl y tar son requeridos. Asegúrate de tenerlos instalados.${NC}">&2
        exit 1
    fi

    echo "Descargando e Instalando Fuentes..."
    sleep 0.5

    for font in "${FONTS[@]}"; do
        local FONT_DIR="$DIR_FONTS/${font}"
        local FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${font}.tar.xz"
        local FONT_ARCHIVE="$DIR_DOWNLOADS/${font}.tar.xz"

        echo "Downloading ${font}..."
        if ! curl -L "$FONT_URL" -o "$FONT_ARCHIVE" --silent --fail; then
            echo -e "${RED}Error: ${font} no se pudo descargar.${NC}"
            continue
        fi

        if ! tar -tf "$FONT_ARCHIVE" &>/dev/null; then
            echo -e "${RED}Error: El archivo ${font} es invalido.${NC}"
            rm -f "$FONT_ARCHIVE"
            continue
        fi

        if [[ -d "$FONT_DIR" ]]; then
            echo -e "${YELLOW}Warning: La carpeta ${font} ya existe. Reemplazandolo...${NC}"
            sudo rm -rf "$FONT_DIR"
        fi

        echo -e "${GREEN}Ok: Instalando ${font}...${NC}"
        sudo mkdir -p "$FONT_DIR"
        if sudo tar -xf "$FONT_ARCHIVE" -C "$FONT_DIR" --wildcards "*.ttf" >/dev/null 2>&1; then
            echo -e "${GREEN}Ok: ${font} instalado correctamente...${NC}"
        else
            echo -e "${RED}Error:  Failed to extract ${font}.${NC}"
        fi
    done

    rm -rf "$DIR_DOWNLOADS"
    echo -e "${GREEN}Ok: Recargando fuente cache...${NC}"
    sudo fc-cache -fv >/dev/null 2>&1
    echo -e "${GREEN}Ok: Instalacion completada!${NC}"
    sleep 0.5
}

install_base_packages
install_yay
install_aur_packages
enable_services
copy_dotfiles
configure_sddm_nopass
install_fonts

echo -e "${CYAN}HAPPY HACKING :)${NC}"