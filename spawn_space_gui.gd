extends SubViewport

@onready var spawn_space_control_node : Control = $SpawnSpaceControl

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_VP_MOUSE_ENTER:
			#print("VP entered")
			spawn_space_control_node.is_mouse_inside = true
		NOTIFICATION_VP_MOUSE_EXIT:
			#print("VP exited")
			spawn_space_control_node.is_mouse_inside = false
