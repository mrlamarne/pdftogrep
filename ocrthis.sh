#!/bin/bash
# Ce script scan via ocrmypdf et génère un pdf "lisible" et un fichier texte, c'est une bonne idée de lancer le grep suivant dérrière :
# grep -i "motATrouver"  ./* -A 1 -B 1'

#Il sera nécéssaier d'avoir les programmes suivants d'installé (dispo dans les depots debian en théorie):
#   ocrmypdf
#   poppler-utils
#

#!/bin/bash

# Chemin vers le dossier contenant les fichiers PDF à convertir
PDF_FOLDER="$1"

# Chemin vers le dossier où enregistrer les fichiers PDF générés
OCR_FOLDER="${PDF_FOLDER}/_ocr"

# Chemin vers le dossier où enregistrer les fichiers fichiers texte générés
TXT_FOLDER="${PDF_FOLDER}/_txt"

# Crée les dossiers _ocr et _txt s'ils n'existent pas
if [ ! -d "$OCR_FOLDER" ]; then
  mkdir "$OCR_FOLDER"
fi

if [ ! -d "$TXT_FOLDER" ]; then
  mkdir "$TXT_FOLDER"
fi

# Boucle sur tous les fichiers PDF du dossier
for file in "${PDF_FOLDER}"/*.pdf; do
  # Nom du fichier PDF généré
  ocr_file="${OCR_FOLDER}/$(basename "${file%.*}")_ocr.pdf"

  # Convertit le fichier PDF avec ocrmypdf
  ocrmypdf "${file}" "${ocr_file}"

  # Génère le fichier texte correspondant
  txt_file="${TXT_FOLDER}/$(basename "${ocr_file}" .pdf).txt"
  pdftotext "${ocr_file}" "${txt_file}"
done
