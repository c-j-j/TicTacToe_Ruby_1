require_relative 'human_player.rb'
require_relative 'computer_player.rb'
require_relative 'board.rb'

module TTT
  class Game

    attr_accessor :current_player
    attr_reader :board
    attr_reader :player_1
    attr_reader :player_2

    GAME_TYPES = {
      '1' => 'Human Vs Human',
      '2' => 'Human Vs Computer',
      '3' => 'Computer Vs Human',
      '4' => 'Computer Vs Computer'
    }

    X = 'X'
    O = 'O'

    def self.build_game_for_user(user_interface)
      board = Board.new
      game_type = user_interface.get_game_type(GAME_TYPES)
      case game_type
      when '1'
        build_hvh_game(board, user_interface)
      when '2'
        build_hvc_game(board, user_interface)
      when '3'
        build_cvh_game(board, user_interface)
      when '4'
        build_cvc_game(board, user_interface)
      end
    end

    def initialize(board, user_interface, player_1, player_2)
      @board = board
      @user_interface = user_interface
      @player_1 = player_1
      @player_2 = player_2
      @current_player = @player_1
    end

    def play
      until @board.game_over?
        play_next_turn
        swap_current_player
      end
      user_interface_outcome
    end

    def user_interface_outcome
      @user_interface.print_tie_message if @board.draw?
      @user_interface.print_winner_message(@board.winner) if @board.won?
    end

    def play_next_turn
      @user_interface.print_board(@board)
      @user_interface.print_next_player_to_go(@current_player.mark)
      @board.add_move(@current_player.mark, @current_player.next_move)
    end

    def swap_current_player
      if @current_player == @player_1
        @current_player = @player_2
      else
        @current_player = @player_1
      end
    end

    private

    def self.build_hvh_game(board, user_interface)
      p1 = TTT::HumanPlayer.new(user_interface, board, X)
      p2 = TTT::HumanPlayer.new(user_interface, board, O)
      new_game(board, user_interface, p1, p2)
    end

    def self.build_cvh_game(board, user_interface)
      p1 = TTT::ComputerPlayer.new(board, O, X)
      p2 = TTT::HumanPlayer.new(user_interface, board, X)
      new_game(board, user_interface, p1, p2)
    end

    def self.build_hvc_game(board, user_interface)
      p1 = TTT::HumanPlayer.new(user_interface, board, X)
      p2 = TTT::ComputerPlayer.new(board, O, X)
      new_game(board, user_interface, p1, p2)
    end

    def self.build_cvc_game(board, user_interface)
      p1 = TTT::ComputerPlayer.new(board, X, O)
      p2 = TTT::ComputerPlayer.new(board, O, X)
      new_game(board, user_interface, p1, p2)
    end

    def self.new_game(board, user_interface, player_1, player_2)
      TTT::Game.new(board, user_interface, player_1, player_2)
    end
  end
end
