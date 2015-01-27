module TTT
  class Board
    attr_accessor :positions

    WINNING_LINES = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ]

    def initialize(positions=nil)
      if positions.nil?
        @positions = Array.new(9)
      else
        @positions = positions.dup
      end
    end

    def ==(o)
      o.class == self.class && o.positions == positions
    end

    def empty_positions
      position_indexes = @positions.map.with_index do |position, index|
        index if position.nil?
      end
      position_indexes.reject{|element| element.nil?}
    end

    def add_move(mark, position)
      @positions[position] = mark
    end

    def is_move_valid?(move)
      return false unless (0...@positions.length) === move
      return @positions[move].nil?
    end

    def won?
      !winner.nil?
    end

    def game_over?
      won? || draw?
    end

    def draw?
      winner.nil? && is_board_full?
    end

    def winner
      winning_line = WINNING_LINES.find do |line|
        all_equal?(@positions[line[0]], @positions[line[1]], @positions[line[2]])
      end
      @positions[winning_line[0]] if !winning_line.nil?
    end

    private

    def all_equal?(*elements)
      elements.all? { |x| x == elements.first && !x.nil?  }
    end

    def is_board_full?
      @positions.all?{|position| position != nil}
    end
  end
end
