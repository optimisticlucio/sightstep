class_name JumpingState
extends FallingState

func _init(player: Player, horizontal_velocity: float = 0):
	super._init(player, Vector2(horizontal_velocity,-700));
