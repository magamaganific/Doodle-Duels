extends Node2D

var points_drawn = []
var colors_used = []
var strokes = 0
var interpolate = []

func _process(delta):
	if Input.is_mouse_button_pressed(1) and Main.is_mouse_inside:
		points_drawn.append(get_local_mouse_position())
		colors_used.append(Main.color)
		queue_redraw()
	if Input.is_action_just_released("LeftClick") and Main.is_mouse_inside:
		strokes += 1

func _draw():
	var i = 0
	var count = 0
	while count < strokes:
		for point in points_drawn:
			draw_circle(point, 5, colors_used[i])
			i += 1

func set_color(Color):
	Main.color = Color

func _on_palette_control_black():
	Main.color = Color(0.0, 0.0, 0.0, 1.0)
