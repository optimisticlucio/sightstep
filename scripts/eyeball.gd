class_name EvilThing
extends Node2D

@export var player: Player;
@onready var pupil = $Pupil;
var eye_wiggle_percentage: float = 0; # A percentage from 0 to 1 of how much the demon eye should wiggle.
#TODO: involve eye wiggle

func _ready() -> void:
	align_eyeball();

func wiggle_eye():
	var _eye_wiggle_limit: float = 0.5;
	
	$Pupil.offset.x = sin(Time.get_unix_time_from_system() * (50 + 50 * eye_wiggle_percentage)) * _eye_wiggle_limit * eye_wiggle_percentage;
	$Pupil.offset.y = cos(Time.get_unix_time_from_system() * (30 + 30 * eye_wiggle_percentage)) * _eye_wiggle_limit * eye_wiggle_percentage;

# Aligns the eyeball to look at the player's current location.
func align_eyeball():
	# This limit is because the sprite dimensions are larger than the actual eyeball.
	var length_limit = 11;
	# Dampener gives false feeling of distance in cases where the player is right next to the eyeball
	var vector_dampener = 0.1;
	
	var eyeball_height = $Eyeball.texture.get_height() * $Eyeball.scale.y * self.scale.y;
	var eyeball_width = $Eyeball.texture.get_width() * $Eyeball.scale.x * self.scale.x;
	
	var vector_to_player = player.position - self.position;
	var vector_to_player_for_circular_eyeball = Vector2(vector_to_player.x * eyeball_height / eyeball_width / self.scale.x, vector_to_player.y / self.scale.y);
	
	# Align eyeball within given limits.
	if (vector_to_player_for_circular_eyeball.length() > length_limit / vector_dampener):
		vector_to_player_for_circular_eyeball = vector_to_player_for_circular_eyeball.normalized() * length_limit / vector_dampener;
	
	vector_to_player = Vector2(vector_to_player_for_circular_eyeball.x * eyeball_width / eyeball_height, vector_to_player_for_circular_eyeball.y);
	vector_to_player *= vector_dampener;
	
	pupil.position = vector_to_player;

# fuck is that noise
func screech():
	$AudioStreamPlayer2D.play();
