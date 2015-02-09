require 'human_player'
require 'game_model_data'
require 'computer_player'
require 'board.rb'

module TTT
  class Game

    attr_accessor :current_player
    attr_reader :board
    attr_reader :player_1
    attr_reader :player_2
    attr_reader :game_type

    MOVE_NOT_AVAILABLE = -1

    HVH = 'Human Vs Human'
    HVC = 'Human Vs Computer'
    CVH = 'Computer Vs Human'
    CVC = 'Computer Vs Computer'

    COMPUTER_PLAYER = 'Computer Player'

    GAME_TYPES = [
      HVH,
      HVC,
      CVH,
      CVC
    ]

    BOARD_SIZES = [
      3,
      4
    ]

    WON = :won
    DRAW = :draw
    IN_PROGRESS = :in_progress

    X = 'X'
    O = 'O'

    MARKS = [X, O]

    def self.build_game(user_interface, game_type, board_size)
      build_game_with_board(user_interface, game_type, Board.new(board_size))
    end

    def self.build_game_with_board(user_interface, game_type, board)
      case game_type
      when HVH
        new_game(user_interface, new_human_player(user_interface),
                 new_human_player(user_interface), board)
      when HVC
        new_game(user_interface, new_human_player(user_interface),
                 new_computer_player, board)
      when CVH
        new_game(user_interface, new_computer_player,
                 new_human_player(user_interface), board)
      when CVC
        new_game(user_interface, new_computer_player,
                 new_computer_player, board)
      end
    end

    def self.default_board_size
      BOARD_SIZES[0]
    end

    def self.default_game_type
      GAME_TYPES[0]
    end

    def initialize(board, user_interface, player_1, player_2)
      @board = board
      @user_interface = user_interface
      @player_1 = player_1
      @player_2 = player_2
      @current_player = @player_1
      @status = IN_PROGRESS
    end

    #TODO to be deprecatd. use play turn instead
    def play
      until game_over?
        print_board
        next_move = get_next_move
        break if next_move == MOVE_NOT_AVAILABLE
        add_move_to_board(next_move)
        swap_current_player
      end

      display_outcome if game_over?
    end

    ##TODO to be deprecatd. use play_turn instead
    def continue_game_with_move(position)
      add_move_to_board(position)
      swap_current_player
      play
    end

    def play_turn(move = nil)
      process_turn(move) unless game_over?
      update_status
    end

    def model_data
      TTT::GameModelData.new(@board, @status, @winner, @current_player.mark, determine_if_computer_player(@current_player), row_size)
    end

    #deprecate
    def display_outcome
      print_board
      @user_interface.print_tie_message if @board.draw?
      @user_interface.print_winner_message(@board.winner) if @board.won?
    end

    def print_board
      @user_interface.print_board(@board)
    end

    def swap_current_player
      if @current_player == @player_1
        @current_player = @player_2
      else
        @current_player = @player_1
      end
    end

    def row_size
      @board.rows.size
    end

    def number_of_positions
      @board.number_of_positions
    end

    def move_valid?(position)
      @board.is_move_valid?(position)
    end

    def get_next_move
      @user_interface.print_next_player_to_go(@current_player.mark)
      @current_player.next_move(@board)
    end

    def add_move_to_board(position)
      @board.add_move(@current_player.mark, position)
    end

    def game_over?
      @board.game_over?
    end

    private

    def process_turn(move)
      move = move || @current_player.next_move(@board)
      if move != MOVE_NOT_AVAILABLE
        add_move_to_board(move)
        swap_current_player
      end
    end

    def determine_if_computer_player(player)
      class_name = player.class.name
      class_name == TTT::ComputerPlayer.name
    end

    def update_status
      if @board.won?
        @status = WON
        @winner = @board.winner
      end
      @status = DRAW if @board.draw?
    end

    def self.new_human_player(user_interface)
      TTT::HumanPlayer.new(user_interface, next_mark)
    end

    def self.new_computer_player
      mark = next_mark
      opponent_mark = get_opponent_mark(mark)
      p1 = TTT::ComputerPlayer.new(mark, opponent_mark)
    end

    def self.get_opponent_mark(mark)
      MARKS.find do |current_mark|
        current_mark != mark
      end
    end

    def self.next_mark
      next_mark = MARKS.shift
      MARKS.push(next_mark)
      next_mark
    end

    def self.new_game(user_interface, player_1, player_2, board)
      TTT::Game.new(board, user_interface, player_1, player_2)
    end
  end
end
