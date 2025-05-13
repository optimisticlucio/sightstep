class_name Player
extends CharacterBody2D

var state: PlayerState;
@onready var audio_stream: AudioStreamPlayer2D = $AudioStreamPlayer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	state = InitialState.new(self);

# Acts out one frame of the state machine.
func state_tick():
	var next_state = state.get_next_state();
	
	if (next_state != state):
		state.exit_state();
		next_state.enter_state();
		state = next_state;
	
	state.act_state();
