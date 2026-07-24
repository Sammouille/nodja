extends Control

# Index comptabilisant le nombre de fois que le mini jeu de soleil est ouvert.
var index := 0

# Fonction appelée par le carnet lorsque la page est ovuerte.
func ouvrirPage():
	# Si la page est réouverte on change la couleur de dessin.
	index += 1
	if index > 1:
		%Dessin.paint_color = Color(randf(), randf(), randf())
	
	# On active le dessin peu de temps après l'ouverture de la page pour pas que ça dessine partout
	await get_tree().create_timer(0.5).timeout
	%Dessin.actif = true

# Fonction appelée par le carnet lorsque la page est fermée.
func fermerPage():
	# On empêche que les clics pendant d'autres pages dessinent également sur celle là.
	%Dessin.actif = false
