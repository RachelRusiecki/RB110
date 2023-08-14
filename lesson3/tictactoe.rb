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

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
def display_board(brd, score1, score2)
  system 'clear'
  puts <<-TEXT
  You're #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}.
  Current Score:
  Player: #{score1}, Computer: #{score2}
  TEXT
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
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

def place_piece!(brd, current_player)
  if current_player == 'player'
    player_places_piece!(brd)
  else
    computer_places_piece!(brd)
  end
end

def alternate_player(current_player)
  current_player == 'player' ? 'computer' : 'player'
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square: (#{joinor(empty_squares(brd))})"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

def find_at_risk_square(line, brd, marker)
  if brd.values_at(*line).count(marker) == 2
    brd.select { |k, v| line.include?(k) && v == INITIAL_MARKER }.keys.first
  end
end

def find_offensive_square(arr, brd)
  square = nil
  arr.each do |line|
    square = find_at_risk_square(line, brd, COMPUTER_MARKER)
    break if square
  end
  square
end

def find_defensive_square(arr, brd)
  square = nil
  arr.each do |line|
    square = find_at_risk_square(line, brd, PLAYER_MARKER)
    break if square
  end
  square
end

def computer_places_piece!(brd)
  square = find_offensive_square(WINNING_LINES, brd)
  square = find_defensive_square(WINNING_LINES, brd) if !square
  if !square && empty_squares(brd).include?(5)
    brd[5] = COMPUTER_MARKER
  elsif !square
    square = empty_squares(brd).sample
    brd[square] = COMPUTER_MARKER
  else
    brd[square] = COMPUTER_MARKER
  end
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

system 'clear'
prompt "Welcome to Tic Tac Toe!"

loop do
  player_score = 0
  computer_score = 0
  board = ''
  first_player = ''

  prompt "First one to win 5 matches wins the game!"
  prompt "Would you like to choose who goes first? (y or n)?"
  answer = gets.chomp

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

  first_player = first_player.start_with?('p') ? 'player' : 'computer'

  prompt "Okay, the #{first_player} will go first. Press Enter to start!"
  gets.chomp

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

    if detect_winner(board) == 'Player'
      player_score += 1
    elsif detect_winner(board) == 'Computer'
      computer_score += 1
    end

    break if player_score == 5 || computer_score == 5

    if someone_won?(board)
      prompt "#{detect_winner(board)} won!"
    else
      prompt "It's a tie!"
    end

    prompt 'Press Enter to play the next match.'
    gets.chomp

    first_player = alternate_player(first_player)
  end

  display_board(board, player_score, computer_score)

  if player_score > computer_score
    prompt 'Congratulations! You won the game!'
  else
    prompt 'Sorry, Computer won the game.'
  end

  prompt 'Play again? (y or n)'
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
  system 'clear'
end

prompt 'Thanks for playing Tic Tac Toe! Good bye!'
