module TTT
  class StubPlayer
    attr_accessor :mark
    attr_accessor :next_move_count

    def initialize
      @mark = generate_random_mark
      @next_move = 0
      @next_move_count = 0
    end

    def generate_random_mark
      rand(100).chr
    end

    def prepare_next_move(next_move)
      @next_move = next_move
    end

    def next_move
      @next_move_count += 1
      return @next_move
    end
  end
end
