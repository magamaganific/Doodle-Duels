extends Control

func _on_black_pressed():
	Main.color = Color(0.0, 0.0, 0.0, 1.0)

func _on_white_pressed():
	Main.color = Color(1.0, 1.0, 1.0, 1.0)

func _on_red_pressed():
	Main.color = Color(1.0, 0.0, 0.0, 1.0)

func _on_orange_pressed():
	Main.color = Color(1.0, 0.478, 0.0, 1.0)

func _on_yellow_pressed():
	Main.color = Color(1.0, 1.0, 0.0, 1.0)

func _on_green_pressed():
	Main.color = Color(0.0, 1.0, 0.0, 1.0)

func _on_blue_pressed():
	Main.color = Color(0.0, 0.0, 1.0, 1.0)

func _on_purple_pressed():
	Main.color = Color(0.478, 0.0, 1.0, 1.0)
