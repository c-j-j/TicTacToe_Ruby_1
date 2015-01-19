module TTT
  class Display
    def initialize(input_stream=$stdin, output_stream=$stdout)
      @input_stream = input_stream
      @output_stream = output_stream
    end

    def get_user_input
      @input_stream.gets.chomp
    end

    def render(output)
      @output_stream.puts output
    end
  end
end
