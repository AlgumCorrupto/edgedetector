extends Node
class_name G

enum shader_types {NONE, RAW, CRISP, FUZZY}
var shaders = [
	load("res://materials/shaders/default.gdshader"),
	load("res://materials/shaders/raw.gdshader"),
	load("res://materials/shaders/crisp.gdshader"),
	load("res://materials/shaders/fuzzy.gdshader"),
]
signal shader_changed(sh: Shader)

enum input_types {IMAGE, CAMERA}
var current_input := input_types.IMAGE
signal input_type_changed(inp: input_types)

var current_image : Texture2D = load("res://test.png")
signal image_changed(image: Texture2D)


func change_shader(i: shader_types):
	shader_changed.emit(shaders[i])

func change_input_type(i: input_types):
	current_input = i
	input_type_changed.emit(i)
	
func change_image(path: String) -> void:
	var image := Image.load_from_file(path)

	if image != null:
		current_image = ImageTexture.create_from_image(image)
		image_changed.emit(current_image)
	else:
		image_changed.emit(load("res://test.png"))
		
		
		
		
