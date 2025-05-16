class_name GameManager
extends Node

@export var level_dir = preload("res://scenes/test_scene.tscn");
var level_node: Node2D;

@export var lights_handler: LightsHandler;
@export var player: Player;
@export var evil_thing: EvilThing;
@export var blackout_rect: ColorRect; # The rectangle that blacks out the whole screen.
@export var exit_door: ExitDoor;

var player_was_seen: bool = false;
var time_to_lights: float = 5; # The time left until the lights are turned on again.

func _ready() -> void:
	#level_node = level_dir.instantiate();
	#get_variables_from_level_scene();
	
	#add_child(level_node);
	
	blackout_rect.visible = !lights_handler.lights_are_on;
	
	lights_handler.lights_off_function = func():
		blackout_rect.visible = true;
	lights_handler.lights_on_function = func():
		blackout_rect.visible = false;
		
	evil_thing.player = player;
	
	player.initiated_movement.connect(did_it_see_you)
	
	player.position = Vector2(123, 370);

func get_variables_from_level_scene():
	lights_handler = level_node.get_node("LightHandler");
	player = level_node.get_node("Player");
	evil_thing = level_node.get_node("Eyeball");
	blackout_rect = level_node.get_node("BlackoutRect");
	exit_door = level_node.get_node("ExitDoor");
	

func _process(delta):
	time_to_lights -= delta;
	
	if (time_to_lights < 0):
		turn_lights_on();
	
	evil_thing.align_eyeball();
	evil_thing.wiggle_eye();

func turn_lights_on() -> void:
	lights_handler.turn_lights_on();
	
	# Now set the time_to_lights something reasonable.
	time_to_lights = lights_handler.animation_handler.current_animation_length
	time_to_lights += 3 + randf_range(0, 3)

# Connecting to the signal of the player changing states.
func did_it_see_you() -> void:
	if (lights_handler.lights_are_on and !player_was_seen):
		it_saw_you()

# Run when the creature spots the player to start the lose condition.
func it_saw_you() -> void:
	player_was_seen = true;
	
	evil_thing.screech();
	evil_thing.eye_wiggle_percentage = 1;
	exit_door.close_door();
	
	await get_tree().create_timer(1.5).timeout;
	
	var evil_hand = preload("res://scenes/za_hando.tscn").instantiate()
	evil_hand.player = player;
	self.get_parent().add_child(evil_hand);
	evil_hand.game_manager = self;
	evil_hand.scale = Vector2(3, 3);
	evil_hand.position = player.position + Vector2(0, 500)

# Ran when a game over situation happens, such as a player falling out of the screen or getting grabbed.
func game_over() -> void:
	return # THIS CODE DOES NOT WORK
	var root_node = get_tree().root
	var level = get_parent()
	
	# ESCAPE THE BURNING HOUSE
	root_node.add_child(self)
	
	level.queue_free()
	
	await get_tree().create_timer(2).timeout;
	
	root_node.add_child(level_node.instantiate())
	
	self.queue_free()
	
