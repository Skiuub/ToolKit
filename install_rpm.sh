#!/bin/bash

# Verificar si se proporcionó un archivo RPM como argumento
if [ -z "$1" ]; then
  echo "Uso: $0 <archivo_rpm>"
  exit 1
fi

# Verificar si el archivo RPM existe
if [ ! -f "$1" ]; then
  echo "El archivo $1 no existe."
  exit 1
fi

# Instalar bsdtar si no está instalado
if ! command -v bsdtar &> /dev/null; then
  echo "bsdtar no está instalado. Instalándolo ahora..."
  sudo pacman -S bsdtar --noconfirm
fi

# Crear un directorio temporal para extraer el contenido del RPM
TEMP_DIR=$(mktemp -d)
echo "Extrayendo el contenido de $1 a $TEMP_DIR..."
bsdtar -xf "$1" -C "$TEMP_DIR"

# Copiar los archivos extraídos a las ubicaciones correspondientes
echo "Copiando archivos extraídos al sistema..."
sudo cp -r "$TEMP_DIR"/* /

# Limpiar el directorio temporal
rm -rf "$TEMP_DIR"

echo "Instalación completada."

# Fin del script