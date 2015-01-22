require_relative 'game.rb'
require_relative 'board.rb'
require_relative 'human_player.rb'
require_relative 'computer_player.rb'

module TTT
  class GameFactory
    def initialize(display)
      @display = display
    end

    def build_hvh_game
      board = TTT::Board.new
      player_1 = TTT::HumanPlayer.new(@display, board, 'X')
      player_2 = TTT::HumanPlayer.new(@display, board, 'O')
      return TTT::Game.new(board, @display, player_1, player_2)
    end

    def build_cvc_game
      board = TTT::Board.new
      player_1 = TTT::ComputerPlayer.new(board, 'X')
      player_2 = TTT::ComputerPlayer.new(board, 'O')
      return TTT::Game.new(board, @display, player_1, player_2)
    end

    def build_hvc_game(first_player)
      board = TTT::Board.new
      human_player = TTT::HumanPlayer.new(@display, board, 'X')
      computer_player = TTT::ComputerPlayer.new(board, 'O')
      if first_player == :computer
        return TTT::Game.new(board, @display, computer_player, human_player)
      else
        return TTT::Game.new(board, @display, human_player, computer_player)
      end
    end

    def build_game_for_user
      case @display.get_game_type  
      when :HVH
        build_hvh_game
      when :CVC
        build_cvc_game
      when :HVC
        build_hvc_game(@display.get_first_player)

      end
    end
  end
end
