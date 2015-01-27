module TTT
  class Display

    TIE_MESSAGE = 'Game is a tie.'
    WINNING_MESSAGE = '%s has won.'
    NEXT_PLAYER_TO_GO = '%s\'s turn.'
    INVALID_MOVE_MESSAGE = 'Invalid move. Try again...'
    PICK_GAME_TYPE = 'Pick Game Type?\n
      1. - Human vs Human\n
      2. Computer vs Computer\n
      3. Human vs Computer\n
      4. Computer vs Human\n'

    def initialize(input=$stdin, output=$stdout)
      @input = input
      @output = output
    end

    def render_board(board)
      output = ""

      board.positions.each_with_index do |player, index|
        unless player.nil?
          output += " #{player.mark} "
        else
          output += " #{index} "
        end

        output += "\n" if (index + 1) % 3 == 0
      end
      @output.puts output
    end

    def print_tie_message
      @output.puts TIE_MESSAGE
    end

    def print_winner_message(player)
      @output.puts WINNING_MESSAGE % player.mark
    end

    def print_next_player_to_go(player)
      @output.puts NEXT_PLAYER_TO_GO % player.mark
    end

    def get_user_input
      @input.gets.chomp
    end

    def print_invalid_message
      @output.puts INVALID_MOVE_MESSAGE
    end

    def get_game_type
      @output.puts PICK_GAME_TYPE
      get_user_input
    end
  end
end
