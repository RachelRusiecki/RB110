SUITS = %w(C D H S)
VALUES = { '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6,
           '7' => 7, '8' => 8, '9' => 9, '10' => 10,
           'Jack' => 10, 'Queen' => 10, 'King' => 10, 'Ace' => 11 }

BUST_LIMIT = 21
DEALER_LIMIT = 17

def display_welcome_message
  system 'clear'
  puts "Welcome to #{BUST_LIMIT}! First to win 5 rounds is the grand winner!"
  puts "The closest to #{BUST_LIMIT} without going over wins the round!"
  puts "Press Enter when your ready to start."
  gets.chomp
end

def initialize_deck
  VALUES.keys.product(SUITS).shuffle.map(&:join)
end

def deal_card(deck, hand)
  current_card = deck.sample
  hand << current_card
  deck.delete(current_card)
end

def calculate_initial_total(real_totals, totals, hand, participant)
  totals[participant] = VALUES[hand[0][0...-1]] + VALUES[hand[1][0...-1]]
  real_totals[participant] = VALUES[hand[0][0...-1]] + VALUES[hand[1][0...-1]]
  determine_ace_value(real_totals, totals, hand, participant)
end

def calculate_player_total(real_totals, totals, current_card)
  totals[:player] += VALUES[current_card[0...-1]]
  real_totals[:player] += VALUES[current_card[0...-1]]
end

def calculate_dealer_total(real_totals, totals, current_card)
  totals[:dealer] += VALUES[current_card[0...-1]]
  real_totals[:dealer] += VALUES[current_card[0...-1]]
end

def determine_ace_value(real_totals, totals, hand, participant)
  if busted?(real_totals, participant)
    ace_count = hand.count { |card| card.start_with?('A') }
    until totals[participant] <= BUST_LIMIT
      if (ace_count * 10) <= (real_totals[participant] - totals[participant])
        break
      end
      totals[participant] -= 10
    end
  end
end

# rubocop:disable Metrics/AbcSize
def display_cards(hand)
  puts ('+-----+ ' * hand.size).to_s
  hand.each do |card|
    print card[0...-1] == '10' ? "|10   | " : "|#{card[0]}    | "
  end
  puts
  hand.each do |card|
    print "|  #{card[-1]}  | "
  end
  puts
  hand.each do |card|
    print card[0...-1] == '10' ? "|   10| " : "|    #{card[0]}| "
  end
  puts
  puts ('+-----+ ' * hand.size).to_s
end
# rubocop:enable Metrics/AbcSize

# rubocop:disable Metrics/AbcSize
def display_first_dealer_card(hand)
  puts "The dealer's card is #{hand[0][0...-1]}."
  puts "+-----+"
  puts hand[0][0...-1] == '10' ? "|10   |" : "|#{hand[0][0]}    |"
  puts "|  #{hand[0][-1]}  |"
  puts hand[0][0...-1] == '10' ? "|   10|" : "|    #{hand[0][0]}|"
  puts "+-----+"
end
# rubocop:enable Metrics/AbcSize

def prompt_hit_or_stay
  answer = ''
  loop do
    puts "Would you like to hit or stay? (h/s)."
    answer = gets.chomp.downcase
    break if answer.start_with?('h') || answer.start_with?('s')
    puts "That answer is invalid. Please type 'h' to hit or 's' to stay."
  end
  answer.start_with?('h') ? 'hit' : 'stay'
end

def busted?(totals, participant)
  totals[participant] > BUST_LIMIT
end

def display_final_player_total(totals)
  puts "Your final total is #{totals[:player]}."
  puts ''
  puts "Now it's the dealer's turn!"
end

def dealer_stays?(totals)
  totals[:dealer] >= DEALER_LIMIT
end

def determine_winner(totals)
  if totals[:player] > BUST_LIMIT
    :dealer
  elsif totals[:dealer] > BUST_LIMIT
    :player
  elsif totals[:player] < totals[:dealer]
    :dealer
  elsif totals[:player] > totals[:dealer]
    :player
  else
    :tie
  end
end

def display_compare_totals(totals)
  puts "================================================"
  puts "Your final score was #{totals[:player]}."
  puts "The dealer's final score was #{totals[:dealer]}."
end

def display_who_won(totals)
  if totals[:player] > BUST_LIMIT
    puts "Sorry, you busted. Dealer won."
  elsif totals[:dealer] > BUST_LIMIT
    puts "The dealer busted. You won!"
  elsif totals[:player] > totals[:dealer]
    display_compare_totals(totals)
    puts "Congratulations! You won!"
  elsif totals[:player] < totals[:dealer]
    display_compare_totals(totals)
    puts "Sorry, dealer won."
  else
    display_compare_totals(totals)
    puts "It's a tie!"
  end
end

def calculate_round_points(totals, point_totals)
  unless determine_winner(totals) == :tie
    point_totals[determine_winner(totals)] += 1
  end
end

def display_score(totals)
  puts "Score: Player-#{totals[:player]}, Dealer-#{totals[:dealer]}"
  puts "Press Enter to continue to the next round."
  gets.chomp
end

def display_grand_winner(totals)
  puts "Congratulations! You are the grand winner!" if totals[:player] >= 5
  puts "Sorry, the dealer is the grand winner." if totals[:dealer] >= 5
end

def play_again?
  puts "Would you like to play again? (y/n)"
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

display_welcome_message

loop do
  point_totals = { player: 0, dealer: 0 }
  loop do
    totals = { player: 0, dealer: 0, tie: 0 }
    real_totals = { player: 0, dealer: 0 }
    loop do
      system 'clear'
      deck = initialize_deck
      current_turn = :player
      player_cards = []

      2.times { deal_card(deck, player_cards) }
      calculate_initial_total(real_totals, totals, player_cards, current_turn)
      first_player_card = player_cards[0][0...-1]
      next_player_card = player_cards[1][0...-1]

      puts "Your cards are #{first_player_card} and #{next_player_card}."
      display_cards(player_cards)
      puts "Your total is #{totals[:player]}."

      current_turn = :dealer
      dealer_cards = []
      2.times { deal_card(deck, dealer_cards) }
      calculate_initial_total(real_totals, totals, dealer_cards, current_turn)
      display_first_dealer_card(dealer_cards)

      loop do
        current_turn = :player
        answer = prompt_hit_or_stay
        break if answer == 'stay'

        current_player_card = deal_card(deck, player_cards)
        deck = initialize_deck if deck.empty?
        calculate_player_total(real_totals, totals, current_player_card)
        determine_ace_value(real_totals, totals, player_cards, current_turn)

        puts "Your next card is #{current_player_card[0...-1]}."
        display_cards(player_cards)
        puts "Your total is #{totals[:player]}."

        break if busted?(totals, current_turn)
      end

      break if busted?(totals, current_turn)
      display_final_player_total(totals)

      current_turn = :dealer
      puts "The dealer's next card is #{dealer_cards[1][0...-1]}."
      display_cards(dealer_cards)
      puts "The dealer's total is #{totals[:dealer]}."

      loop do
        break if dealer_stays?(totals)
        puts "Press enter to continue."
        gets.chomp
        current_dealer_card = deal_card(deck, dealer_cards)
        deck = initialize_deck if deck.empty?
        calculate_dealer_total(real_totals, totals, current_dealer_card)
        determine_ace_value(real_totals, totals, dealer_cards, current_turn)

        puts "The dealer's next card is #{current_dealer_card[0...-1]}."
        display_cards(dealer_cards)
        puts "The dealer's total is #{totals[:dealer]}."
      end

      break if dealer_stays?(totals)
    end

    display_who_won(totals)
    calculate_round_points(totals, point_totals)
    display_score(point_totals)

    break if point_totals.values.any? { |score| score >= 5 }
  end

  display_grand_winner(point_totals)
  break unless play_again?
end

puts "Thank you for playing #{BUST_LIMIT}! Goodbye!"
