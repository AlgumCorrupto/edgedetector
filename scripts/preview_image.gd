extends Sprite2D

@onready var cam := $"../camera"

func _ready():
	get_viewport().size_changed.connect(_update_scale)
	_update_scale()
	Global.image_changed.connect(_change_texture)
	Global.shader_changed.connect(_update_shaders)

func _change_texture(tex: Texture2D):
	texture = tex
	_update_scale()
	
func _update_shaders(s: Shader):
	material.shader = s

func _update_scale():
	var cam_size = get_viewport().get_visible_rect().size / cam.zoom
	var tex_size = texture.get_size()
	var fit_scale = min(
		cam_size.x / tex_size.x,
		cam_size.y / tex_size.y
	)

	scale = Vector2.ONE * fit_scale
