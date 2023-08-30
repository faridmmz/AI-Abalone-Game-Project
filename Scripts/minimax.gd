extends Reference

class_name minimax

var chosen_state
var minimax_value

func _init():
	self.chosen_state = State.new(BoardManager.current_board, 0, 0)
	self.minimax_value = -1
	
func set_chosen_state(state):
	self.chosen_state = state
	
func  set_minimax_value(minimax_value):
	self.minimax_value = minimax_value
	
