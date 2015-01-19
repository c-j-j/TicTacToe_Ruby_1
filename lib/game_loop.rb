module TTT
  class GameLoop
    def initialize(game)
      @game = game
    end
  
    def run
      until @game.game_over?
        @game.update_with_next_player_move
        @game.render  
      end

      @game.display_outcome
    end
  end
end
