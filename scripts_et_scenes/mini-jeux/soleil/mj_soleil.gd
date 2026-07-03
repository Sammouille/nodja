extends Control

var index := 0


func ouvrirPage():
	%Dessin.actif = true
	index += 1
	if index > 1:
		%Dessin.paint_color = Color(randf(), randf(), randf())

func fermerPage():
	%Dessin.actif = false
