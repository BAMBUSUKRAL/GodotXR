extends XROrigin3D

# Ensure these paths match your scene tree exactly
@onready var left_controller: XRController3D = $LeftController
@onready var right_controller: XRController3D = $RightController
@onready var left_hand_mesh: XRNode3D = $LeftHandTracker
@onready var right_hand_mesh: XRNode3D = $RightHandTracker

func _process(_delta: float) -> void:
	# Update both hands every frame
	_update_hand_visibility("/user/hand_tracker/left", left_hand_mesh, left_controller)
	_update_hand_visibility("/user/hand_tracker/right", right_hand_mesh, right_controller)

func _update_hand_visibility(tracker_name: StringName, hand_node: Node3D, controller_node: Node3D) -> void:
	var tracker = XRServer.get_tracker(tracker_name)
	
	# has_tracking_data is true only when the cameras actually see your hands
	if tracker and tracker.has_tracking_data:
		hand_node.visible = true
		controller_node.visible = false
	else:
		hand_node.visible = false
		controller_node.visible = true
