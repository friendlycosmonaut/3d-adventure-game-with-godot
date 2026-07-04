extends CharacterBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_right"):
		position.x = position.x + 0.1
	if Input.is_action_pressed("ui_left"):
		position.x = position.x - 0.1
	if Input.is_action_pressed("ui_up"):
		position.z = position.z - 0.1
	if Input.is_action_pressed("ui_down"):
		position.z = position.z + 0.1
