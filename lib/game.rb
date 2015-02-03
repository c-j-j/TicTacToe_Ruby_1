require_relative 'human_player.rb'
require_relative 'computer_player.rb'
require_relative 'board.rb'

module TTT
  class Game

    attr_accessor :current_player
    attr_reader :board
    attr_reader :player_1
    attr_reader :player_2

    MOVE_NOT_AVAILABLE = -1

    HVH = 'Human Vs Human'
    HVC = 'Human Vs Computer'
    CVH = 'Computer Vs Human'
    CVC = 'Computer Vs Computer'

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

    X = 'X'
    O = 'O'

    def self.build_game(user_interface, game_type, board_size)
      case game_type
      when HVH
        game = build_hvh_game(user_interface, board_size)
      when HVC
        game = build_hvc_game(user_interface, board_size)
      when CVH
        game = build_cvh_game(user_interface, board_size)
      when CVC
        game = build_cvc_game(user_interface, board_size)
      end
      game
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
    end

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

    def continue_game_with_move(position)
      add_move_to_board(position)
      swap_current_player
      play
    end

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
      @board.positions.size
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

    private

    def game_over?
      @board.game_over?
    end

    def self.build_hvh_game(user_interface, board_size)
      p1 = TTT::HumanPlayer.new(user_interface, X)
      p2 = TTT::HumanPlayer.new(user_interface, O)
      new_game(user_interface, p1, p2, board_size)
    end

    def self.build_cvh_game(user_interface, board_size)
      p1 = TTT::ComputerPlayer.new(O, X)
      p2 = TTT::HumanPlayer.new(user_interface, X)
      new_game(user_interface, p1, p2, board_size)
    end

    def self.build_hvc_game(user_interface, board_size)
      p1 = TTT::HumanPlayer.new(user_interface, X)
      p2 = TTT::ComputerPlayer.new(O, X)
      new_game(user_interface, p1, p2, board_size)
    end

    def self.build_cvc_game(user_interface, board_size)
      p1 = TTT::ComputerPlayer.new(X, O)
      p2 = TTT::ComputerPlayer.new(O, X)
      new_game(user_interface, p1, p2, board_size)
    end

    def self.new_game(user_interface, player_1, player_2, board_size)
      TTT::Game.new(Board.new(board_size), user_interface, player_1, player_2)
    end
  end
end
