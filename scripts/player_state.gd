class_name PlayerState

var player: Player;

func _init(player: Player):
	self.player = player;

func get_next_state() -> PlayerState:
	return self;

func act_state(delta):
	pass

func enter_state():
	pass

func exit_state():
	pass
