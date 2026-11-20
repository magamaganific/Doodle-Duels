extends Node2D

var points_drawn = []
var colors_used = []
var strokes = []
var interpolate = []

func _process(delta):
	if Input.is_mouse_button_pressed(1) and Main.is_mouse_inside:
		points_drawn.append(get_local_mouse_position())
		colors_used.append(Main.color)
		queue_redraw()

func _draw():
	var i = 0
	for point in points_drawn:
		draw_circle(point, 5, colors_used[i])
		i += 1
	interpolate.append(i)

func set_color(Color):
	Main.color = Color


func _on_palette_control_black():
	Main.color = Color(0.0, 0.0, 0.0, 1.0)
