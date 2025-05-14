class_name FallingState
extends PlayerState

var _ascending_gravity: float = 1600; # Gravity applied going up
var _descending_gravity: float = 2300; # Gravity applied going down
var _max_downward_speed: float; #TODO : Max falling speed

func _init(player: Player, initial_vector: Vector2 = Vector2.ZERO):
	super._init(player);
	player.velocity = initial_vector;

func get_next_state() -> PlayerState:
	if (player.is_on_floor()):
		return InitialState.new(self.player);
	
	return self;

func act_state(delta):
	var downward_gravity;
	
	if (player.velocity.y > 0):
		downward_gravity = _descending_gravity;
	else:
		downward_gravity = _ascending_gravity;
	
	player.velocity.y += downward_gravity * delta;
	
	player.move_and_slide()

func enter_state():
	self.player.animated_sprite.animation = "hop";

func exit_state():
	var landing_noise = preload("res://assets/sfx/landing.wav")
	
	player.audio_stream.stream = landing_noise
	player.audio_stream.play()
