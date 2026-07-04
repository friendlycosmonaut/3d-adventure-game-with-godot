extends Node3D

@export_range(0.0, 1.0) var mouse_sensitivity = 0.01
@export_range(0.0, 90.0) var tilt_limit = 70.0
@export_range(0.0, 1.0) var damping = 0.1

@onready var spring_arm = get_node("SpringArm3D")

var following = null
var x_target = 0.0
var y_target = 0.0


func _process(delta: float) -> void:
	global_position = following.global_position
	
	rotation.x = lerp_angle(rotation.x, x_target, damping)
	rotation.y = lerp_angle(rotation.y, y_target, damping)
	
	var tilt_radians = deg_to_rad(tilt_limit)
	rotation.x = clamp(rotation.x, -tilt_radians, tilt_radians)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		x_target -= event.relative.y * mouse_sensitivity
		y_target -= event.relative.x * mouse_sensitivity


func set_following(node: Node3D) -> void:
	spring_arm = get_node("SpringArm3D")
	if following != null:
		spring_arm.remove_excluded_object(following)
	following = node
	spring_arm.add_excluded_object(node)
