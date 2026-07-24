extends Control

# Index indiquant à quelle page on se trouve (numéro de page)
var index_page:= 0

# Référence (= pointeur) à la page actuellement ouverte qui garde en mémoire la Node de la page
var page_active: Page

## Liste à remplir grâce à l'inspecteur en séléctionnant la node dans la scène.
@export var pages: Array[Page]

# Fonction qui se lance au début de l'execution et qui s'occupe d'une part 
# de bien placer les signets mais aussi de connecter leur signaux.
func _ready() -> void:
	actualiser_affichage()
	for page in pages:
		page.clic_signet.connect(changer_page)
	actualiser_affichage()


# Fonction appelée par le fait de cliquer sur un signet, 
# et s'occupe de changer de page
func changer_page(page_visee: Page):
	# Si la page de couverture était toujours visible on l'efface.
	if %PremierePage.visible:
		%PremierePage.hide()
	# Si une page était affichée, on la cache
	if page_active:
		page_active.fermer_page()
	
	# On change quelle est la page active / visible.
	page_active = page_visee
	page_active.ouvrir_page()
	index_page = page_active.index
	# On actualise l'affichage des signets
	actualiser_affichage()

# Fonction qui s'occupe de placer correctement les signets, appelée au lancement
# et à chaque changement de page.
func actualiser_affichage():
	for page in pages:
# Les signets des pages passées passent sur la gauche du carnet et en dessous des pages.
		if page.index < index_page:
			page.signet.position.x = page.x_signet_gauche
			page.signet.z_index = -1
# Les signets des pages pas encore passées passent sur la droite du carnet et en dessous des pages
		elif page.index > index_page:
			page.signet.position.x = page.x_signet_droite
			page.signet.z_index = -1
# Le signet de la page active est mis au dessus des pages et se place à gauche
		else:
			page.signet.position.x = page.x_signet_gauche
			page.signet.z_index = 2
			
