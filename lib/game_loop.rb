module TTT
  class GameLoop
    def initialize(game)
      @game = game
    end
  
    def run
      @game.render

      until (@game.game_over?)
        @game.update_with_player_1_input
        @game.render  
        if (@game.game_over?)
          break
        end
        @game.update_with_player_2_input
        @game.render
      end
      @game.display_outcome
    end
  end
end
