extends Node3D

# ############################################################################### #
# NOTE: Este código está directamente copiado de la demo de gui_panel_3d de godot #
# ############################################################################### #

var last_event_pos2D := Vector2()
var last_event_time := -1.0

@onready var node_viewport: SubViewport = $CanvasViewport
@onready var node_quad: MeshInstance3D = $CanvasArea
@onready var node_area: Area3D = $CanvasArea/Area3D

func _ready() -> void:
	node_area.mouse_entered.connect(_mouse_entered_area)
	node_area.mouse_exited.connect(_mouse_exited_area)
	node_area.input_event.connect(_mouse_input_event)
	if node_quad.get_surface_override_material(0).billboard_mode == BaseMaterial3D.BillboardMode.BILLBOARD_DISABLED:
		set_process(false)

func _process(_delta: float) -> void:
	rotate_area_to_billboard()

func _mouse_entered_area() -> void:
	Main.is_mouse_inside = true
	node_viewport.notification(NOTIFICATION_VP_MOUSE_ENTER)

func _mouse_exited_area() -> void:
	node_viewport.notification(NOTIFICATION_VP_MOUSE_EXIT)
	Main.is_mouse_inside = false

func _unhandled_input(input_event: InputEvent) -> void:
	for mouse_event in [InputEventMouseButton, InputEventMouseMotion, InputEventScreenDrag, InputEventScreenTouch]:
		if is_instance_of(input_event, mouse_event):
			return
	node_viewport.push_input(input_event)



func _mouse_input_event(_camera: Camera3D, input_event: InputEvent, event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void: 
	var quad_mesh_size: Vector2 = node_quad.mesh.size
	var event_pos3D := event_position
	var now := Time.get_ticks_msec() / 1000.0
	event_pos3D = node_quad.global_transform.affine_inverse() * event_pos3D
	
	var event_pos2D := Vector2()
	if Main.is_mouse_inside:
		event_pos2D = Vector2(event_pos3D.x, -event_pos3D.y)
		event_pos2D.x = event_pos2D.x / quad_mesh_size.x
		event_pos2D.y = event_pos2D.y / quad_mesh_size.y
		event_pos2D.x += 0.5
		event_pos2D.y += 0.5
		event_pos2D.x *= node_viewport.size.x
		event_pos2D.y *= node_viewport.size.y

	elif last_event_pos2D != null:
		event_pos2D = last_event_pos2D

	input_event.position = event_pos2D
	if input_event is InputEventMouse:
		input_event.global_position = event_pos2D

	if input_event is InputEventMouseMotion or input_event is InputEventScreenDrag:
		if last_event_pos2D == null:
			input_event.relative = Vector2(0, 0)
		else:
			input_event.relative = event_pos2D - last_event_pos2D
			input_event.velocity = input_event.relative / (now - last_event_time)
	last_event_pos2D = event_pos2D
	last_event_time = now
	node_viewport.push_input(input_event)


func rotate_area_to_billboard() -> void:
	var billboard_mode: BaseMaterial3D.BillboardMode = node_quad.get_surface_override_material(0).billboard_mode
	if billboard_mode > 0:
		var camera := get_viewport().get_camera_3d()
		var look := camera.to_global(Vector3(0, 0, -100)) - camera.global_transform.origin
		look = node_area.position + look
		if billboard_mode == 2:
			look = Vector3(look.x, 0, look.z)
		node_area.look_at(look, Vector3.UP)
		node_area.rotate_object_local(Vector3.BACK, camera.rotation.z)
