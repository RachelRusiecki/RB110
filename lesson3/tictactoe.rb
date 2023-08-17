require 'pry'

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], # rows
                 [1, 4, 7], [2, 5, 8], [3, 6, 9], # cols
                 [1, 5, 9], [3, 5, 7]]            # diagonals
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

def prompt(msg)
  puts "=> #{msg}"
end

def print_welcome_message
  prompt "First one to win 5 matches wins the game!"
  prompt "Would you like to choose who goes first? (y or n)?"
end

def determine_who_starts(answer)
  first_player = ''
  if answer.downcase.start_with?('y')
    loop do
      prompt "Who would you like to go first, player (p) or computer (c)?"
      first_player = gets.chomp.downcase
      break if first_player.start_with?('p') || first_player.start_with?('c')
      prompt "That entry is invalid. Type 'p' for player or 'c' for computer."
    end
  else
    first_player = ['computer', 'player'].sample
  end
  first_player
end

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
def prompt_who_starts(first_player)
  if first_player == 'player'
    prompt "Okay, you will go first."
  else
    prompt "Okay, the computer will go first."
  end
  prompt "Here are the corresponding squares. Press Enter to start!"
  puts ""
  puts "     |     |"
  puts "  1  |  2  |  3"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  4  |  5  |  6"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  7  |  8  |  9"
  puts "     |     |"
  puts ""
  gets.chomp
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
def display_board(board, score1, score2)
  system 'clear'
  puts <<-TEXT
  You're #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}.
  Current Score:
  Player: #{score1}, Computer: #{score2}
  TEXT
  puts ""
  puts "     |     |"
  puts "  #{board[1]}  |  #{board[2]}  |  #{board[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{board[4]}  |  #{board[5]}  |  #{board[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{board[7]}  |  #{board[8]}  |  #{board[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(board)
  board.keys.select { |num| board[num] == INITIAL_MARKER }
end

def joinor(arr, delimiter = ', ', end_separator = 'or')
  if arr.size == 1
    arr[0].to_s
  elsif arr.size == 2
    "#{arr[0]} #{end_separator} #{arr[1]}"
  else
    "#{arr[0..-2].join(delimiter)}#{delimiter}#{end_separator} #{arr[-1]}"
  end
end

def place_piece!(board, current_player)
  if current_player == 'player'
    player_places_piece!(board)
  else
    computer_places_piece!(board)
  end
end

def alternate_player(current_player)
  current_player == 'player' ? 'computer' : 'player'
end

def player_places_piece!(board)
  square = ''
  loop do
    prompt "Choose a square: (#{joinor(empty_squares(board))})"
    square = gets.chomp.to_i
    break if empty_squares(board).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
  board[square] = PLAYER_MARKER
end

def find_at_risk_square(line, board, marker)
  if board.values_at(*line).count(marker) == 2
    board.select { |k, v| line.include?(k) && v == INITIAL_MARKER }.keys.first
  end
end

def find_offensive_square(arr, board)
  square = nil
  arr.each do |line|
    square = find_at_risk_square(line, board, COMPUTER_MARKER)
    break if square
  end
  square
end

def find_defensive_square(arr, board)
  square = nil
  arr.each do |line|
    square = find_at_risk_square(line, board, PLAYER_MARKER)
    break if square
  end
  square
end

def computer_places_piece!(board)
  square = find_offensive_square(WINNING_LINES, board)
  square = find_defensive_square(WINNING_LINES, board) if !square
  if !square && empty_squares(board).include?(5)
    board[5] = COMPUTER_MARKER
  elsif !square
    square = empty_squares(board).sample
    board[square] = COMPUTER_MARKER
  else
    board[square] = COMPUTER_MARKER
  end
end

def board_full?(board)
  empty_squares(board).empty?
end

def someone_won?(board)
  !!detect_winner(board)
end

def detect_winner(board)
  WINNING_LINES.each do |line|
    if board.values_at(*line).count(PLAYER_MARKER) == 3
      return 'You'
    elsif board.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def display_round_winner(board)
  if someone_won?(board)
    prompt "#{detect_winner(board)} won!"
  else
    prompt "It's a tie!"
  end
  prompt 'Press Enter to play the next match.'
  gets.chomp
end

def display_game_winner(player_score, computer_score)
  if player_score > computer_score
    prompt 'Congratulations! You won the game!'
  else
    prompt 'Sorry, Computer won the game.'
  end
end

def print_goodbye_message
  prompt 'Thanks for playing Tic Tac Toe! Good bye!'
end

system 'clear'
prompt "Welcome to Tic Tac Toe!"

loop do
  player_score = 0
  computer_score = 0
  board = ''

  print_welcome_message
  answer = gets.chomp
  first_player = determine_who_starts(answer)
  first_player = first_player.start_with?('p') ? 'player' : 'computer'
  prompt_who_starts(first_player)

  loop do
    board = initialize_board
    current_player = first_player

    loop do
      display_board(board, player_score, computer_score)
      place_piece!(board, current_player)
      current_player = alternate_player(current_player)
      break if someone_won?(board) || board_full?(board)
    end

    display_board(board, player_score, computer_score)

    if detect_winner(board) == 'You'
      player_score += 1
    elsif detect_winner(board) == 'Computer'
      computer_score += 1
    end

    break if player_score == 2 || computer_score == 2

    display_round_winner(board)

    first_player = alternate_player(first_player)
  end

  display_board(board, player_score, computer_score)
  display_game_winner(player_score, computer_score)

  prompt 'Play again? (y or n)'
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
  system 'clear'
end

print_goodbye_message
