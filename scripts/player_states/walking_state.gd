class_name WalkingState
extends PlayerState

var _walking_speed: float = 400; # The speed at which the player moves in any direction.
var facing_right: float;

func _init(player: Player, facing_right: bool):
	super._init(player);
	self.facing_right = facing_right;

func get_next_state() -> PlayerState:
	if (!player.is_on_floor()):
		return FallingState.new(self.player, Vector2(_walking_speed * (1 if facing_right else -1), 0));
	if ((!Input.is_action_pressed("right") && facing_right) || (!Input.is_action_pressed("left") && !facing_right)):
		return InitialState.new(self.player)
	if (Input.is_action_pressed("jump")):
		return JumpingState.new(self.player, _walking_speed*4/5 * (1 if facing_right else -1))
	
	return self;

func act_state(delta):
	player.move_and_slide()

func enter_state():
	player.animated_sprite.animation = "walk_right";
	player.velocity = Vector2(_walking_speed * (1 if facing_right else -1), 0)
	
	var stream = preload("res://assets/sfx/steps.ogg")
	stream.loop = true
	player.audio_stream.stream = stream
	player.audio_stream.play()

func exit_state():
	player.audio_stream.stop()
