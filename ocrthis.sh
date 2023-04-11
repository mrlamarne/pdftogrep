#!/bin/bash
# Ce script scan via ocrmypdf et génère un pdf "lisible" et un fichier texte, c'est une bonne idée de lancer le grep suivant dérrière : 
# grep -i "motATrouver"  ./* -A 1 -B 1'


# Chemin vers le dossier contenant les fichiers PDF à convertir
PDF_FOLDER="./"

# Chemin vers le dossier où enregistrer les fichiers PDF générés
OCR_FOLDER="${PDF_FOLDER}/_ocr"

# Chemin vers le dossier où enregistrer les fichiers texte générés
TXT_FOLDER="${PDF_FOLDER}/_txt"

# Crée les dossiers _ocr et _txt s'ils n'existent pas
if [ ! -d "$OCR_FOLDER" ]
then
    mkdir "$OCR_FOLDER"
fi

if [ ! -d "$TXT_FOLDER" ]
then
    mkdir "$TXT_FOLDER"
fi

# Boucle sur tous les fichiers PDF du dossier
for file in "$PDF_FOLDER"/*.pdf
do
    # Vérifie si le fichier est un fichier PDF
    if [[ "${file##*.}" == "pdf" ]]
    then
        # Nom du fichier PDF généré
        ocr_file="${OCR_FOLDER}/$(basename "${file%.*}")_ocr.pdf"

        # Convertit le fichier PDF avec ocrmypdf
        ocrmypdf "$file" "$ocr_file"

        # Génère le fichier texte correspondant
        txt_file="${TXT_FOLDER}/$(basename "${ocr_file%.*}").txt"
        pdftotext "$ocr_file" "$txt_file"
    fi
done

