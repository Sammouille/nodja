extends Node
#Singleton qui est appelable à n'importe quel moment et de n'importe où dans le jeu. Permet de faire le lien entre plusieurs scripts facilement.

#Variable qui enregistre le mini-jeu actuellement à l'écran.
var current_mj = "null"

#Variable qui enregistre quel objet de l'inventaire est en train d'être drag.
var draging_element_inventaire = "null"

#Variable qui va prendre valeur dans jantes.gd qui permet de faire le lien entre le minijeu demarrer_voiture et la voiture.
var je_suis_voiture_jante : CharacterBody2D = null

#Dictionnaire regroupant les langues possibles par index. Même ordre d'index que pour le OptionButton qui permet de choisir la langue.
var dict_index_language = {
	0 : "fr",
	1 : "eng",
}
