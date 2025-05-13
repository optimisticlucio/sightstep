class_name InitialState
extends PlayerState

func get_next_state() -> PlayerState:
	if (Input.is_action_pressed("down")):
		return CrouchingState.new(self.player);
	if (Input.is_action_pressed("space")):
		return JumpingState.new(self.player);
	if (Input.is_action_pressed("right") != Input.is_action_pressed("left")):
		return WalkingState.new(self.player, Input.is_action_pressed("right"))
	
	return self;

func act_state():
	pass

func enter_state():
	self.player.animated_sprite.animation = "idle";

func exit_state():
	pass
