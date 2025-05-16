class_name Player
extends CharacterBody2D

signal initiated_movement;

var state: PlayerState;
@onready var audio_stream: AudioStreamPlayer2D = $AudioStreamPlayer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	state = InitialState.new(self);

func _physics_process(delta):
	state_tick(delta);

# Acts out one frame of the state machine.
func state_tick(delta):
	var next_state = state.get_next_state();
	
	if (next_state != state):
		state.exit_state();
		next_state.enter_state();
		print(next_state.get_script().get_global_name())
		if (next_state.get_script().get_global_name() != "InitialState"):
			initiated_movement.emit();
		state = next_state;
	
	state.act_state(delta);
