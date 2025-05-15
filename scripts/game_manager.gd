class_name GameManager
extends Node

@export var lights_handler: LightsHandler;
@export var player: Player;
@export var evil_thing: EvilThing;
@export var blackout_rect: ColorRect; # The rectangle that blacks out the whole screen.

var time_to_lights: float = 5; # The time left until the lights are turned on again.

func _ready() -> void:
	blackout_rect.visible = !lights_handler.lights_are_on;
	
	lights_handler.lights_off_function = func():
		blackout_rect.visible = true;
	lights_handler.lights_on_function = func():
		blackout_rect.visible = false;
		
	evil_thing.player = player;

func _process(delta):
	time_to_lights -= delta;
	
	if (time_to_lights < 0):
		turn_lights_on();
	
	if (lights_handler.lights_are_on):
		evil_thing.align_eyeball();

func turn_lights_on() -> void:
	lights_handler.turn_lights_on();
	
	# Now set the time_to_lights something reasonable.
	time_to_lights = lights_handler.animation_handler.current_animation_length
	time_to_lights += 5 + randf_range(0, 3)

# Run when the creature spots the player to start the lose condition.
func it_saw_you() -> void:
	pass
