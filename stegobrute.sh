#!/bin/bash

# Autor: Juan Carlos Rodríguez (ju4ncaa)

# Paleta de colores ANSI
GREEN="\e[1;92m"
RED="\e[1;91m"
YELLOW="\e[1;93m"
CYAN="\e[1;96m"
PURPLE="\e[1;35m"
RESET="\e[1;97m"

# Variables
FILE=$1
DICT=$2
OUTPUT=$3

# Funciones

# Exit function
stty -ctlecho
trap ctrl_c INT
function ctrl_c() {
    tput cnorm
    echo -e  "\n${RED}[!]${RESET} Saliendo...\n"; exit 1
}

function banner(){
  echo -e "${YELLOW}  ____  _                   ____             _       ${RESET}"
  echo -e "${YELLOW} / ___|| |_ ___  ____  ___ | __ ) _ __ _   _| |_ ___ ${RESET}"
  echo -e "${YELLOW} \___ \| __/ _ \/ _  |/ _ \|  _ \|  __| | | | __/ _ \ ${PURPLE} Autor: @ju4ncaa (Juan Carlos Rodríguez)${RESET}"
  echo -e "${YELLOW}  ___) | ||  __/ (_| | (_) | |_) | |  | |_| | ||  __/ ${RESET}"
  echo -e "${YELLOW} |____/ \__\___|\__  |\___/|____/|_|   \____|\__\___| ${RESET}"
  echo -e "${YELLOW}                |___/                                ${RESET}"
}

# Help panel function
function help_panel(){
    echo -e "\n${YELLOW}[+] Uso:${RESET}\n"
    echo -e "\t${PURPLE}Sintaxis:${RESET} $0 <imagen> <diccionario> <archivo_salida>\n"
    echo -e "${CYAN}[+] Ejemplo:${RESET} $0 imagen.jpeg /usr/share/wordlists/rockyou.txt salida.txt"
}

function check_tools() {
    tput civis; stty -echo
    if ! command -v steghide &>/dev/null; then
	echo -e "\n${RED}[!]${RESET} La herramienta ${YELLOW}steghide${RESET} no se encuentra instalada en el sistema!"; sleep 1
	echo -e  "\n${YELLOW}[*]${RESET} Instalando ${YELLOW}steghide${RESET} en el sistema"; sleep 1
	apt install steghide &>/dev/null
	if [ "$(echo $?)"  == "0" ]; then
		sleep 2; echo -e "\n${GREEN}[+]${RESET} Herramienta ${YELLOW}steghide${RESET} instalada correctamente!"
	else
		sleep 2; echo -e "\n${RED}[!]${RESET} Ha ocurrido un problema en el proceso de instalación!"; exit 1
	fi
    fi
   tput cnorm; stty echo
}

function extract_data() {
	tput civis
	echo -e  "\n${GREEN}[+]${RESET} Iniciando proceso de fuerza bruta...\n"; sleep 1
	while IFS= read -r PASS; do
		steghide extract -sf "$FILE" -xf "$OUTPUT" -p "$PASS" &>/dev/null
		if [ $? -eq 0 ]; then
            		echo -e "\n${GREEN}[+]${RESET} Contraseña encontrada: ${YELLOW}${PASS}${RESET}\n"
            		echo -e "${GREEN}[*]${RESET} Información extraída correctamente en: ${YELLOW}${OUTPUT}${RESET}\n"
            		return 0
        	fi
	done < "$DICT"
	echo -e "\n${RED}[!]${RESET} No se encontró una contraseña válida en el diccionario.\n"
    	tput cnorm; exit 1
}

function validate_ext() {
    tput civis
    if ! [[ "$FILE" =~ \.(jpg|jpeg)$ ]]; then
        echo -e "\n${RED}[!]${RESET} La imagen proporcionada debe tener la extensión ${YELLOW}JPG${RESET} o ${YELLOW}JPEG${RESET}\n"
        exit 1
    fi
    tput cnorm
}

if [ "$(id -u )" == "0" ]; then
	banner
	if [ $# -ne 3 ]; then
		echo -e  "\n${RED}[!] ERROR:${RESET} Debes de introducir 3 argumentos obligatorios\n"; help_panel; exit 1
	else
		if [ -e "$FILE" ] && [ -e "$DICT" ]; then
			validate_ext
			check_tools
			extract_data
		else
			echo -e "\n${RED}[!] ERROR:${RESET} En los argumentos debes de proporcionar archivos existentes en el sistema!\n"; help_panel; exit 1
		fi
	fi
else
        echo -e "\n${RED}[!]${RESET} Se requieren permisos de superusuario ${RED}(root)${RESET} para ejecutar el script"
	exit 1
fi
