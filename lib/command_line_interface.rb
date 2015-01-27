module TTT
  class CommandLineInterface

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

    def print_board(board)
      output = ""

      board.positions.each_with_index do |mark, index|
        unless mark.nil?
          output += " #{mark} "
        else
          output += " #{index + 1} "
        end

        output += "\n" if (index + 1) % 3 == 0
      end
      @output.puts output
    end

    def print_tie_message
      @output.puts TIE_MESSAGE
    end

    def print_winner_message(mark)
      @output.puts WINNING_MESSAGE % mark
    end

    def print_next_player_to_go(mark)
      @output.puts NEXT_PLAYER_TO_GO % mark
    end

    def get_user_input
      @input.gets.chomp
    end

    def get_user_move(board)
      while(true)
        move = get_user_input
        break if is_valid?(move, board)
        print_invalid_message
      end
      transform_input_to_position(move)
    end

    def is_valid?(move, board)
      is_i?(move) && board.is_move_valid?(transform_input_to_position(move))
    end

    def is_i?(string)
      !!(string =~ /\A[-+]?[0-9]+\z/)
    end

    def is_integer?(string)
      string.to_i.to_s == self
    end

    def print_invalid_message
      @output.puts INVALID_MOVE_MESSAGE
    end

    def get_game_type
      @output.puts PICK_GAME_TYPE
      get_user_input
    end

    private

    def transform_input_to_position(move)
      move.to_i - 1
    end
  end
end
