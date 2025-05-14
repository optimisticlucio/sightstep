class_name EvilThing
extends Node2D

@export var player: Player;
@onready var pupil = $Pupil;

func _ready() -> void:
	align_eyeball(); # FOR TESTING!

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
