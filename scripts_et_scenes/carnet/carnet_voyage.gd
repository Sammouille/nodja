extends Control

var index_page:= 0

var page_active: Page

@export var pages: Array[Page]

func _ready() -> void:
	actualiser_affichage()
	for page in pages:
		page.clic_signet.connect(changer_page)

func changer_page(page_visee: Page):
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
				page.signet.position.x = -abs(page.x_signet) -40
			page.signet.z_index = 2
		elif page.index > index_page:
			if page.signet.position.x < 0.0:
				page.signet.position.x = abs(page.x_signet) 
			page.signet.z_index = 0
		else:
			page.signet.position.x = page.x_signet
			page.signet.z_index = 2
			
