class_name CrouchingState
extends PlayerState

func get_next_state() -> PlayerState:
	#if (player.is_on_floor()):
	#	return FallingState.new(self.player);
	if (!Input.is_action_pressed("down")):
		return InitialState.new(self.player);
	#if (Input.is_action_pressed("jump")):
	#	return JumpingState.new(self.player);
	
	return self;

func act_state(delta):
	pass

func enter_state():
	self.player.animated_sprite.animation = "crouch";

func exit_state():
	pass
