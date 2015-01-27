require_relative 'game.rb'
require_relative 'board.rb'
require_relative 'human_player.rb'
require_relative 'computer_player.rb'

module TTT
  class GameFactory

    X = 'X'
    O = 'O'

    def initialize(display)
      @display = display
      @board = TTT::Board.new
    end

    def build_game_for_user
      case @display.get_game_type
      when '1'
        build_hvh_game
      when '2'
        build_cvc_game
      when '3'
        build_hvc_game
      when '4'
        build_cvh_game
      end
    end

    def build_hvh_game
      new_game(human_player(X), human_player(O))
    end

    def build_cvc_game
      new_game(computer_player(X, O), computer_player(O, X))
    end

    def build_hvc_game
      new_game(human_player(X), computer_player(O, X))
    end

    def build_cvh_game
      new_game(computer_player(X, O), human_player(O))
    end

    private

    def new_game(player_1, player_2)
      TTT::Game.new(@board, @display, player_1, player_2)
    end

    def human_player(mark)
      TTT::HumanPlayer.new(@display, @board, mark)
    end

    def computer_player(mark, opponent_mark)
      TTT::ComputerPlayer.new(@board, mark, opponent_mark)
    end
  end
end
