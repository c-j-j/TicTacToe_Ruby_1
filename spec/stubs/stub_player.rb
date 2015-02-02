module TTT
  class StubPlayer
    attr_accessor :mark
    attr_accessor :next_move_count

    def initialize(mark)
      @mark = mark
      @next_move = 0
      @next_move_count = 0
    end

    def prepare_next_move(next_move)
      @next_move = next_move
    end

    def next_move(board)
      @next_move_count += 1
      return @next_move
    end
  end
end
