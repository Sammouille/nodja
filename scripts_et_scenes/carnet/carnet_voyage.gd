extends Control

var index_page:= 0

var page_active: Page

@export var pages: Array[Page]

func _ready() -> void:
	actualiser_affichage()

func changer_page(page_visee: Page):
	if page_active:
		page_active.hide()
	
	page_active = page_visee
	page_active.ouvrir_page()
	index_page = page_active.index
	actualiser_affichage()
	
	

func actualiser_affichage():
	for page in pages:
		if page.index < index_page:
			if page.signet.position.x > 0.0:
				page.signet.position.x = -page.signet.position.x
		elif page.index > index_page:
			if page.signet.position.x < 0.0:
				page.signet.position.x = -page.signet.position.x


func _on_double_page_clic_signet(page: Variant) -> void:
	changer_page(page)
