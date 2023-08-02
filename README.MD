# Animesame RSS - Guide d'utilisation

Ce programme est conçu pour afficher le planning des épisodes d'anime à partir d'un fichier JSON en ligne en utilisant le mod ComputerCraft.

## Prérequis :
1. Ce programme nécessite l'installation du mod ComputerCraft dans Minecraft.
2. Assurez-vous que l'API HTTP est activée dans le fichier "ComputerCraft.cfg" avant d'utiliser ce programme.

## Source des données :
Le fichier JSON utilisé par ce programme est hébergé dans le dépôt GitHub "https://github.com/Dartsgame974/animesame-rss". Ce fichier est régulièrement mis à jour par un script Google Apps Script toutes les deux heures. Le script effectue une requête API avec un token personnel pour mettre à jour le fichier "flux.json" du dépôt GitHub avec les informations les plus récentes sur les épisodes d'anime.

## Installation :
Pour installer le programme, exécutez la commande suivante dans l'ordinateur Minecraft :



    wget https://github.com/Dartsgame974/animesame-rss/raw/main/aspocket.lua


## Utilisation :
1. Au démarrage, l'image "boot.nfp" sera affichée pendant 3 secondes.
2. Ensuite, le menu principal affichera les jours disponibles.
3. Utilisez les touches directionnelles pour sélectionner le jour souhaité.
4. Appuyez sur la touche "Entrée" pour afficher les épisodes pour le jour sélectionné.
5. Les épisodes seront affichés par groupes de 3.
6. Utilisez les touches directionnelles pour naviguer entre les pages d'épisodes.
7. Pour revenir au menu principal depuis la liste des épisodes, appuyez à nouveau sur la touche "Entrée".

## Note :
Le fichier JSON utilisé par ce programme est régulièrement mis à jour toutes les deux heures grâce à un script Google Apps Script. Le script utilise un token personnel pour effectuer une requête API et mettre à jour le fichier "flux.json" du dépôt GitHub. Cette mise à jour permet d'obtenir les informations les plus récentes sur les épisodes d'anime.

_made with ChatGPT 3.5 Turbo"_


_Discord Dartsgame#7825(dartsgame)_

> Source de la page : [anime-sama.fr](https://anime-sama.fr/)

> **Remarque :** Ce projet n'est pas destiné à un usage commercial, mais à des fins éducatives et de loisirs.
