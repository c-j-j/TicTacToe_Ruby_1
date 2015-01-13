module TTT
  class HumanPlayer
    def initialize(cli_renderer)
      @cli_renderer = cli_renderer
    end

    def next_move
      invalid_move = true
      while(invalid_move)
        user_input = @cli_renderer.get_user_input
        if(is_move_valid(user_input))
          invalid_move = false
        end
      end
      user_input.to_i
    end

    def is_move_valid(user_input)
      user_input.match(/^(\d)+$/) 
    end
  end
end
