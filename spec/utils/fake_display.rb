module TTT
  class FakeDisplay

    def initialize
      @renders = []
    end

    def render(output_string)
      @renders << output_string 
    end

    def render_board(board)

    end

    def get_previous_renders
      @renders
    end

    def set_user_input(*mocked_user_input)
      @user_input = mocked_user_input
    end

    def get_user_input
      @user_input.shift
    end
  end
end
