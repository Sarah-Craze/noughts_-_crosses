class Board
  attr_accessor :board_cases
  
  def initialize
    @board_cases = create_board
  end
  
  def create_board
    positions = ("A1".."C3").to_a
    positions.map { |pos| BoardCase.new(pos) }
  end
 
  
  def play_turn(player)
    puts "#{player.name}, enter your move (e.g., A1):"
    move = gets.chomp.upcase
  
    board_case = @board_cases.find { |bc| bc.position == move && bc.value == " " }
  
    if board_case
      board_case.value = player.symbol
    else
      puts "Invalid move. Try again."
      play_turn(player)
    end
  end
 

  def create_board
    positions = ("A".."C").to_a.product(("1".."3").to_a).map { |pos| pos.join }
    positions.map { |pos| BoardCase.new(pos) }
  end
  
  

  def display_board
    puts "    1   2   3"
    puts "  +---+---+---+"

    @board_cases.each_slice(3).with_index do |row, i|
      print "#{(i + 1 + 64).chr} |"  # Convert numbers to letters: 1 -> A, 2 -> B, etc.
      row.each { |cell| print " #{cell.value.to_s.tr('123', 'ABC')} |" } 
      puts "\n  +---+---+---+"
    end
end
  

  def victory?
    # Vérifie les lignes, colonnes et diagonales pour déterminer s'il y a un vainqueur.
    winning_combinations = [
      [@board_cases[0], @board_cases[1], @board_cases[2]],
      [@board_cases[3], @board_cases[4], @board_cases[5]],
      [@board_cases[6], @board_cases[7], @board_cases[8]],
      [@board_cases[0], @board_cases[3], @board_cases[6]],
      [@board_cases[1], @board_cases[4], @board_cases[7]],
      [@board_cases[2], @board_cases[5], @board_cases[8]],
      [@board_cases[0], @board_cases[4], @board_cases[8]],
      [@board_cases[2], @board_cases[4], @board_cases[6]]
    ]
  
    winning_combinations.each do |combination|
      values = combination.map(&:value)
      return true if values.uniq.length == 1 && values[0] != " "
    end
  
    # Si aucune combinaison gagnante n'est trouvée, vérifie s'il y a un match nul.
    return true if @board_cases.all? { |bc| bc.value != " " }
  
    false
  end
end
