@tool
class_name NinePatchPanel extends NinePatchRect


enum ColorChoice{VIRIDIAN, CELADON, PLATINUM, CINEROUS, NIGHT, TANGERINE, ENGLISH_VIOLET, ROSE_QUARTZ}

const ColorDict: Dictionary[ColorChoice, Color] = {
	ColorChoice.VIRIDIAN : Color("5B9279"),
	ColorChoice.CELADON : Color("8FCB9B"),
	ColorChoice.PLATINUM : Color("EAE6E5"),
	ColorChoice.CINEROUS : Color("8F8073"),
	ColorChoice.NIGHT : Color("12130F"),
	ColorChoice.TANGERINE : Color("F1AB86"),
	ColorChoice.ENGLISH_VIOLET : Color("694D75"),
	ColorChoice.ROSE_QUARTZ : Color("B4A6AB"),
}

@export var color_choice: ColorChoice :
	set(val) :
		color_choice = val
		if color_rect:
			color_rect.color = ColorDict[color_choice]

@export var color_rect: ColorRect

func _ready() -> void:
	print(ColorDict[color_choice])
	color_rect.color = ColorDict[color_choice]
