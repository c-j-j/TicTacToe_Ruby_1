module TTT
  class Display

    TIE_MESSAGE = 'Game is a tie.'
    WINNING_MESSAGE = '%s has won.'
    NEXT_PLAYER_TO_GO = '%s\'s turn.'
    INVALID_MOVE_MESSAGE = 'Invalid move. Try again...'

    def initialize(input_stream=$stdin, output_stream=$stdout)
      @input_stream = input_stream
      @output_stream = output_stream
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
      @output_stream.puts output
    end

    def print_tie_message
      @output_stream.puts TIE_MESSAGE
    end

    def print_winner_message(player)
      @output_stream.puts WINNING_MESSAGE % player.mark
    end

    def print_next_player_to_go(player)
      @output_stream.puts NEXT_PLAYER_TO_GO % player.mark      
    end

    def get_user_input
      @input_stream.gets.chomp
    end
    
    def print_invalid_message
      @output_stream.puts INVALID_MOVE_MESSAGE
    end
  end
end
