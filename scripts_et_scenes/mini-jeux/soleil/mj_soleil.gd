extends Control

# Index comptabilisant le nombre de fois que le mini jeu de soleil est ouvert.
var index := 0

# Fonction appelée par le carnet lorsque la page est ovuerte.
func ouvrirPage():
	%Dessin.actif = true
	
	# Si la page est réouverte on change la couleur de dessin.
	index += 1
	if index > 1:
		%Dessin.paint_color = Color(randf(), randf(), randf())

# Fonction appelée par le carnet lorsque la page est fermée.
func fermerPage():
	# On empêche que les clics pendant d'autres pages dessinent également sur celle là.
	%Dessin.actif = false
