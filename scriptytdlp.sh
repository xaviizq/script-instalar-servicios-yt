#!/bin/bash

# yt-dlp esta instalado?
if ! command -v yt-dlp &> /dev/null; then
    echo "yt-dlp no está instalado, instalando..."
    pip install yt-dlp
fi

if ! command -v ffmpeg &> /dev/null; then
    echo "ffmpeg no está instalado, instalando..."
    sudo apt install ffmpeg  # o el gestor de paquetes de tu sistema
fi

# Pedir URL de YouTube al usuario
read -p "Introduce la URL del vídeo de YouTube: " video_url

# Obtener formatos disponibles del vídeo
echo "Obteniendo formatos disponibles del vídeo..."
yt-dlp -F "$video_url"

# Pedir al usuario que elija el formato del vídeo
read -p "Selecciona el formato del vídeo (código del formato): " video_format

# Extraer audio en formato mp3
echo "Extrayendo audio en formato mp3..."
yt-dlp -x --audio-format mp3 -o "audio.mp3" "$video_url"

# Descargar vídeo sin audio en el formato seleccionado
echo "Descargando vídeo sin audio en formato comprimido..."
yt-dlp -f "$video_format" -o "video_sin_audio.$(yt-dlp -e --ext '$video_format')" "$video_url"

# Mostrar información del audio y del vídeo al terminar (opcional)
echo "Información del audio:"
ffprobe -i "audio.mp3"

echo "Información del vídeo sin audio:"
ffprobe -i "video_sin_audio.$(yt-dlp -e --ext '$video_format')"

echo "Proceso completado."
