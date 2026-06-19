extends Control

var index_page:= 0

var page_active: Page

@export var pages: Array[Page]

func _ready() -> void:
	actualiser_affichage()
	for page in pages:
		page.clic_signet.connect(changer_page)
	actualiser_affichage()

func changer_page(page_visee: Page):
	if %PremierePage.visible:
		%PremierePage.hide()
	if page_active:
		page_active.fermer_page()
	
	page_active = page_visee
	page_active.ouvrir_page()
	index_page = page_active.index
	actualiser_affichage()
	print(index_page)
	

func actualiser_affichage():
	for page in pages:
		if page.index < index_page:
			if page.signet.position.x > 0.0:
				if page.x_signet < -100:
					page.signet.position.x = page.x_signet
				else:
					page.signet.position.x = -page.x_signet - 100
			page.signet.z_index = 0
		elif page.index > index_page:
			if page.signet.position.x < 0.0:
				if page.x_signet < -100:
					page.signet.position.x = abs(page.x_signet) - 100
				else:
					page.signet.position.x = page.x_signet
			page.signet.z_index = 0
		else:
			page.signet.position.x = page.x_signet
			page.signet.z_index = 2
			
