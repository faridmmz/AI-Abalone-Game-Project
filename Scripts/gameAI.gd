extends Node

export var visualizer_path : NodePath
onready var visualizer = get_node(visualizer_path)

var current_black_score = 0
var current_white_score = 0

var transition_table = []

var max_depth = 2
var best_state = null

var turn_condition = false
var stop_game = false

var player = 1

var state_to_scroll = 0

func _ready():
	"""
	var minimax = minimax(BoardManager.current_board, player, max_depth, true)	
	visualizer.update_board(best_state.board)
	BoardManager.current_board = best_state.board
	transition_table.append(best_state.board)
	turn_condition = true
	player = 2
	
	var alphabeta = alphabeta(BoardManager.current_board, player, max_depth, true, alpha, beta)	
	visualizer.update_board(best_state.board)
	BoardManager.current_board = best_state.board
	transition_table.append(best_state.board)
	turn_condition = true
	player = 2
	alpha = -500
	beta = 500
	"""
	var alphabeta = forward_pruning_alphabeta(BoardManager.current_board, player, max_depth, true, alpha, beta)	
	visualizer.update_board(best_state.board)
	BoardManager.current_board = best_state.board
	transition_table.append(best_state.board)
	state_to_scroll += 1
	turn_condition = true
	player = 2
	alpha = -500
	beta = 500



func _process(_delta):
	if not stop_game:
		"""
		if turn_condition:
			var minimax = minimax(BoardManager.current_board, player, max_depth, true)	
			visualizer.update_board(best_state.board)
			BoardManager.current_board = best_state.board
			transition_table.append(best_state.board)
			turn_condition = false
			player = 1
		else:
			var minimax = minimax(BoardManager.current_board, player, max_depth, true)	
			visualizer.update_board(best_state.board)
			BoardManager.current_board = best_state.board
			transition_table.append(best_state.board)
			turn_condition = true
			player = 2
		
		if turn_condition:
			var alphabeta = alphabeta(BoardManager.current_board, player, max_depth, true, alpha, beta)	
			visualizer.update_board(best_state.board)
			BoardManager.current_board = best_state.board
			transition_table.append(best_state.board)
			turn_condition = false
			player = 1
			alpha = -500
			beta = 500
		else:
			var alphabeta = alphabeta(BoardManager.current_board, player, max_depth, true, alpha, beta)	
			visualizer.update_board(best_state.board)
			BoardManager.current_board = best_state.board
			transition_table.append(best_state.board)
			turn_condition = true
			player = 2
			alpha = -500
			beta = 500
		"""
		if turn_condition:
			var alphabeta = forward_pruning_alphabeta(BoardManager.current_board, player, max_depth, true, alpha, beta)	
			visualizer.update_board(best_state.board)
			BoardManager.current_board = best_state.board
			transition_table.append(best_state.board)
			state_to_scroll += 1
			turn_condition = false
			player = 1
			alpha = -500
			beta = 500
		else:
			var alphabeta = forward_pruning_alphabeta(BoardManager.current_board, player, max_depth, true, alpha, beta)	
			visualizer.update_board(best_state.board)
			BoardManager.current_board = best_state.board
			transition_table.append(best_state.board)
			state_to_scroll += 1
			turn_condition = true
			player = 2
			alpha = -500
			beta = 500
	
	engage()

		
func engage():
	if Input.is_action_just_pressed("ui_cancel"):
		if stop_game:
			stop_game = false
			print("game resumed")
			
	
		else:
			stop_game = true
			print("game stoped")
			
	if Input.is_action_just_pressed("ui_left"):
		if stop_game:
			
			state_to_scroll = state_to_scroll - 1
			BoardManager.current_board =transition_table[state_to_scroll]
			visualizer.update_board(BoardManager.current_board)
			
			
	if Input.is_action_just_pressed("ui_right"):
		if stop_game:
			
			state_to_scroll = state_to_scroll + 1
			BoardManager.current_board =transition_table[state_to_scroll]
			visualizer.update_board(BoardManager.current_board)
			
func minimax(current_board, piece, depth, max_player):
	if check_winner(current_board):
		return minimax_eval(current_board,piece) * 100
	
	if depth == 0:
		
		return minimax_eval(current_board,piece)
	
	if max_player:
		var max_value = -500
		var max_state = State.new(current_board,current_black_score,current_white_score)
		var successors = Successor.calculate_successor(max_state, piece)
		if piece == 1:
			piece = 2
		else:
			piece = 1
		for successor in successors:
			var check_loop = false
			for i in range (len(transition_table)):
				if transition_table[i] == successor.board:
					check_loop = true
			if not check_loop:
				var current_value = minimax(successor.board, piece, depth - 1, false)
				if current_value > max_value:
					max_value = current_value
					best_state = successor
		return max_value
	else:
		var min_value = 500
		var min_state = State.new(current_board,current_black_score,current_white_score)
		var successors = Successor.calculate_successor(min_state, piece)
		if piece == 1:
			piece = 2
		else:
			piece = 1
		for successor in successors:
			var check_loop = false
			for i in range (len(transition_table)):
				if transition_table[i] == successor.board:
					check_loop = true
			if not check_loop:
				var current_value = minimax(successor.board, piece, depth - 1, true)
				if current_value < min_value:
					min_value = current_value
		return min_value

var alpha = -500
var beta = 500

func alphabeta(current_board, piece, depth, max_player, alpha, beta):
	if check_winner(current_board):
		return minimax_eval(current_board,piece) * 100
	
	if depth == 0:
		return minimax_eval(current_board,piece)
	
	if max_player:
		var max_value = -500
		var max_state = State.new(current_board,0,0)
		var successors = Successor.calculate_successor(max_state, piece)
		if piece == 1:
			piece = 2
		else:
			piece = 1
			
		for successor in successors:
			var check_loop = false
			for i in range (len(transition_table)):
				if transition_table[i] == successor.board:
					check_loop = true
			
			if not check_loop: 
				var current_value = alphabeta(successor.board, piece, depth - 1, false, alpha, beta)
				if current_value > max_value:
					max_value = current_value
					best_state = successor
					if alpha < max_value:
						alpha = max_value
						
			if beta <= alpha:
				break
		return max_value
	else:
		var min_value = 1000
		var min_state = State.new(current_board,0,0)
		var successors = Successor.calculate_successor(min_state, piece)
		if piece == 1:
			piece = 2
		else:
			piece = 1
	
		for successor in successors:
			
			var check_loop = false
			for i in range (len(transition_table)):
				if transition_table[i] == successor.board:
					check_loop = true
			
			if not check_loop:
				var current_value = alphabeta(successor.board, piece, depth-1, true, alpha, beta)
				if current_value < min_value:
					min_value = current_value
					if beta > min_value:
						beta = min_value
			if beta <= alpha:
				break
		return min_value

var prune_count = 5

func forward_pruning_alphabeta(current_board, piece, depth, max_player, alpha, beta):
	if check_winner(current_board):
		return minimax_eval(current_board,piece) * 100
	
	if depth == 0:
		return minimax_eval(current_board,piece)
	
	if max_player:
		var max_value = -500
		var max_state = State.new(current_board,0,0)
		var successors = Successor.calculate_successor(max_state, piece)
		if piece == 1:
			piece = 2
		else:
			piece = 1
			
		var forward_prunes = []
		for successor in successors:
			forward_prunes.append(minimax_eval(successor.board, piece))
		
		for i in range (0, len(forward_prunes) - 1):
			for j in range(0, len(forward_prunes) - i - 1):
				if forward_prunes[j] > forward_prunes[j+1]:
					var x = forward_prunes[j]
					forward_prunes[j] = forward_prunes[j+1]
					forward_prunes[j+1] = x
					
					var y = successors[j]
					successors[j] = successors[j+1]
					successors[j+1] = y
		
		for unpruned in range(0, prune_count):
			var check_loop = false
			for i in range (len(transition_table)):
				if transition_table[i] == successors[unpruned].board:
					check_loop = true
			
			if not check_loop: 
				var current_value = forward_pruning_alphabeta(successors[unpruned].board, piece, depth - 1, false, alpha, beta)
				if current_value > max_value:
					max_value = current_value
					best_state = successors[unpruned]
					if alpha < max_value:
						alpha = max_value
						
			if beta <= alpha:
				break
		return max_value
	else:
		var min_value = 500
		var min_state = State.new(current_board,0,0)
		var successors = Successor.calculate_successor(min_state, piece)
		if piece == 1:
			piece = 2
		else:
			piece = 1
			
		var forward_prunes = []
		for successor in successors:
			forward_prunes.append(minimax_eval(successor.board, piece))
		
		
		for i in range (0, len(forward_prunes) - 1):
			for j in range(0, len(forward_prunes) - i - 1):
				if forward_prunes[j] < forward_prunes[j+1]:
					var x = forward_prunes[j]
					forward_prunes[j] = forward_prunes[j+1]
					forward_prunes[j+1] = x
					
					var y = successors[j]
					successors[j] = successors[j+1]
					successors[j+1] = y

		for unpruned in range (0, prune_count):
			var check_loop = false
			for i in range (len(transition_table)):
				if transition_table[i] == successors[unpruned].board:
					check_loop = true
			
			if not check_loop:
				var current_value = forward_pruning_alphabeta(successors[unpruned].board, piece, depth-1, true, alpha, beta)
				if current_value < min_value:
					min_value = current_value
					if beta > min_value:
						beta = min_value
			if beta <= alpha:
				break
		return min_value


func check_winner(board):
	var black_count = 0
	var white_count = 0
	for i in range(61):
		if board[i] == 1:
			black_count = black_count + 1
		if board[i] == 2:
			white_count = white_count + 1
	if black_count <= 8 or white_count <= 8:
		return true
		
		
func minimax_eval(board, piece):
	#checking how close to center pieces are
	var heuristic = 0
	var total_distance = 100
	var enemy_piece
	var cohesion_count = 0
	if piece == 1:
		enemy_piece = 2
	else:
		enemy_piece = 1
	for i in range(61):
		if board[i] == piece:
			total_distance -= get_distance_to_center(i)
		if board[i] == enemy_piece:
			total_distance += 2 * get_distance_to_center(i)
	
	var piece_count = 0
	var enemy_piece_count = 0
	for i in range(61):
		if board[i] == piece:
			piece_count += 1
		elif board[i] == enemy_piece:
			enemy_piece_count += 1
	
	for i in range(61):
		if board[i] == piece:
			for j in range(6):
				if BoardManager.neighbors[i][j] != -1 and board[BoardManager.neighbors[i][j]] == piece:
					cohesion_count += 1
		
	
	
	heuristic += (piece_count - enemy_piece_count) * 300
	heuristic += total_distance
	heuristic += cohesion_count
	return heuristic
	
func get_distance_to_center(i):
	if (i >= 0 and i <= 5) or i == 11 or i == 18 or i == 26 or i == 35 or i == 43 or i == 50 or (i >= 55 and i <= 60) or i == 49 or i == 42 or i == 34 or i == 25 or i == 17 or i == 10:
		return 40
	elif (i >= 6 and i <= 9) or i == 12 or i == 19 or i == 27 or i == 36 or i == 44 or ( i >= 51 and i <= 54) or i == 48 or i == 41 or i == 33 or i == 24 or i == 16:
		return 30
	elif  i == 13 or i == 14 or i == 15 or i == 23 or i == 32 or i == 40 or i == 47 or i == 46 or i == 45 or i == 37 or i == 28 or i == 20:
		return 20
	elif i == 21 or i == 22 or i == 31 or i == 39 or i == 38 or i == 29:
		return 10
	else:
		return 5
