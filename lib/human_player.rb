module TTT
  class HumanPlayer
    def initialize(cli_renderer)
      @cli_renderer = cli_renderer
    end

    def next_move
      @cli_renderer.get_user_input.to_i
    end
  end
end
