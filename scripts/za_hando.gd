extends Node2D

var player: Player;
var _player_chasing_speed: float = 400;
var game_manager: GameManager;


func _process(delta: float) -> void:
	var normalized_direction_to_player = (player.position - self.position).normalized();
	
	self.position += normalized_direction_to_player * _player_chasing_speed * delta;


func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body is Player):
		game_manager.game_over();
