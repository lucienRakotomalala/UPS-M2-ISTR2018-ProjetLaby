#!/bin/bash
#                 Labyrinthe 1 joueur - Documentation
# Script de lancement de la génération automatique de la documentation.
#
# S'exécute sur linux. (testé uniquement sur Ubuntu 17.10)
#
# Il est nécessaire d'avoir installé :
#             * doxygen :   Générateur de documentation
#               (s'installe avec la commande "sudo apt-get install doxygen")
#             * graphviz :  Générateur de graph pour les graphs de la doc.
#               (s'installe avec la commande "sudo apt-get install graphviz")
#             * latex :     Pour compiler la doc en pdf.
#               (s'installe avec la commande "sudo apt-get install texlive")
#               Il est possible d'installé la version "texlive-full"
#               pour avoir tous les paquets mais c'est volumineux.

# script qui compile la génération doxygen et les sources latex générées
doxygen ./doc/Doxyfile
cd doc/latex/
make all
#evince refman.pdf &    # affiche la documentation pdf.
cd ../..
# Fichier pour ouvrir :
#     * La documentation pdf :  doc/latex/refman.pdf
#     * La documentation html : doc/html/index.html
