extends Node2D

var points_drawn = []
var colors_used = []
var strokes = 0
var interpolate = [Rect2(Vector2(-1, -1), Vector2(-1, -1))]
var prevpoint = interpolate[0].position
var active = false

func _process(_delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and Main.is_mouse_inside and get_global_mouse_position() != prevpoint:
		if interpolate[strokes].position == Vector2(-1, -1):
			interpolate[strokes].position = get_global_mouse_position()
			interpolate.append(Rect2(Vector2(-1, -1), Vector2(-1, -1)))
			#print("Start position[",strokes,"]", interpolate[strokes].position)
		points_drawn.append(get_global_mouse_position())
		colors_used.append(Main.color)
		prevpoint = get_global_mouse_position()
		queue_redraw()
	if (Input.is_action_just_released("LeftClick") and interpolate[strokes].position != Vector2(-1, -1))\
		or (!Main.is_mouse_inside and interpolate[strokes].position != Vector2(-1, -1)):
		interpolate[strokes].size = prevpoint
		#print("-End:  position[",strokes,"]", prevpoint)
		strokes += 1

func _draw():
	var i = 0
	var nstroke = 0
	for point in points_drawn:
		if nstroke <= strokes and point == interpolate[nstroke].position:
			active = true
			prevpoint = point
		if active == true:
			draw_line(prevpoint, point, colors_used[i], 10)
		if nstroke < strokes and point == interpolate[nstroke].size:
			active = false
			nstroke += 1
		draw_circle(point, 5, colors_used[i])
		prevpoint = point
		i += 1
	active = false
