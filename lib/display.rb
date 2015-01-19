module TTT
  class Display
    def initialize(input_stream=$stdin, output_stream=$stdout)
      @input_stream = input_stream
      @output_stream = output_stream
    end

    def render_board(board)
      output = ""

      board.positions.each_with_index do |player, index|
        if player != nil
          output += " #{player.mark} " if player != nil
        else
          output += " #{index} " 
        end

        output += "\n" if (index + 1) % 3 == 0
      end
      @output_stream.puts output
    end

    def get_user_input
      @input_stream.gets.chomp
    end

    def render(output)
      @output_stream.puts output
    end
  end
end
