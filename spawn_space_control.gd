extends Control

@export var is_mouse_inside := true
@export var space_size : Vector2
var origin : Vector2 = Vector2.ZERO
var end : Vector2

func _process(_delta):
	if Input.is_action_just_pressed("LeftClick") and is_mouse_inside:
		origin = get_local_mouse_position()
		print("doode space origin set to:", origin)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and is_mouse_inside:
		queue_redraw()
	if Input.is_action_just_released("LeftClick"):
		end = get_local_mouse_position()
		print("doode space end set to:", end)
		space_size = end - origin
		print("calculation = ", space_size)

func _draw() -> void:
	draw_rect(Rect2(origin, get_local_mouse_position() - origin), Main.color, false, 1, false)
	print("calculation = ", get_local_mouse_position() - origin)
