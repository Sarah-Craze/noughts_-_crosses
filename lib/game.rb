class Game
  attr_accessor :current_player, :status, :board, :players

  def initialize
    @players = create_players
    @board = Board.new
    @status = "on going"
    @current_player = @players[0]
  end

  def create_players
    puts "Welcome to the game of Noughts & Crosses."
    puts " "
    puts "Please enter the name of Player 1 (❌):"
    name1 = gets.chomp
    puts " "
    puts "Please enter the name of Player 2 (⭕):"
    name2 = gets.chomp
    puts " "

    [Player.new(name1, "❌"), Player.new(name2, "⭕")]
  end

  def turn
    board.display_board
    board.play_turn(current_player)

    if board.victory?
      @status = current_player
    elsif board.board_cases.all? { |bc| bc.value != " " }
      @status = "draw"
    else
      switch_player
    end
  end

  def new_round
    @board = Board.new
    @status = "on going"
  end

  def switch_player
    @current_player = (@current_player == @players[0]) ? @players[1] : @players[0]
  end

  def game_end
    board.display_board

    if @status == "draw"
      puts "It's a draw! 🤝".colorize(:red)
    else
      puts "#{current_player.name} wins! 🏆".colorize(:red)
    end
  end
end
