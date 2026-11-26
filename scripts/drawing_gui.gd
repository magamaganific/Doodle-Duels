extends SubViewport

@onready var drawing_control_node : Node2D = $DrawingSpace2D/CanvasPaintControl

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_VP_MOUSE_ENTER:
			#print("VP entered")
			drawing_control_node.is_mouse_inside = true
		NOTIFICATION_VP_MOUSE_EXIT:
			#print("VP exited")
			drawing_control_node.is_mouse_inside = false
