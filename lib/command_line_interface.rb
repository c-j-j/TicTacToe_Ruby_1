module TTT
  class CommandLineInterface

    TIE_MESSAGE = 'Game is a tie.'
    WINNING_MESSAGE = '%s has won.'
    NEXT_PLAYER_TO_GO = '%s\'s turn.'
    INVALID_MOVE_MESSAGE = 'Invalid input. Try again...'
    PICK_GAME_TYPE = "Pick Game Type?\n"

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

    def get_user_move(board)
      while true
        move = get_user_input
        break if is_move_valid?(move, board)
        print_invalid_message
      end
      transform_integer_input_to_zero_based(move)
    end

    def print_invalid_message
      @output.puts INVALID_MOVE_MESSAGE
    end

    def get_game_type(game_choices)
      @output.puts PICK_GAME_TYPE
      while true
        print_game_choices(game_choices)
        game_type = get_user_input
        break if game_type_valid?(game_type, game_choices)
        print_invalid_message
      end
      game_choices.keys[transform_integer_input_to_zero_based(game_type)]
    end

    private

    def print_game_choices(game_choices)
      game_choices.each_with_index do |(game_type, game_description), index|
        @output.puts "#{index + 1}: #{game_description}\n"
      end
    end

    def game_type_valid?(game_type, game_choices)
      is_integer?(game_type) && (1..game_choices.size) === game_type.to_i
    end

    def transform_integer_input_to_zero_based(move)
      move.to_i - 1
    end

    def get_user_input
      @input.gets.chomp
    end

    def is_move_valid?(move, board)
      # TODO is this a code smell?
      is_integer?(move) && board.is_move_valid?(transform_integer_input_to_zero_based(move))
    end

    def is_integer?(string)
      !!(string =~ /\A[-+]?[0-9]+\z/)
    end
  end
end
