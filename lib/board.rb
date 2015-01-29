module TTT
  class Board
    attr_accessor :positions

    def initialize(number_of_rows, positions=nil)
      if positions.nil?
        @positions = Array.new(number_of_rows ** 2)
      else
        @positions = positions
      end
    end

    def copy
      Board.new(@size, positions.dup)
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
      winning_line = winning_lines.find do |line|
        all_equal?(line)
      end

      extract_mark_from_winning_line(winning_line) unless winning_line.nil?
    end

    def rows
      @positions.each_slice(Math.sqrt(@positions.size)).to_a
    end

    private

    def winning_lines
      rows + cols + diagonals
    end

    def cols
      rows.transpose
    end

    def diagonals
      [diagonal_top_left, diagonal_top_right]
    end

    def diagonal_top_left
      rows.collect.with_index do |row, index|
        row[index]
      end
    end

    def diagonal_top_right
      rows.collect.with_index do |row, index|
        row.reverse[index]
      end
    end

    def extract_mark_from_winning_line(line)
      line[0]
    end

    def all_equal?(elements)
      elements.all? { |x| x == elements.first && !x.nil?  }
    end

    def is_board_full?
      @positions.all?{|position| position != nil}
    end
  end
end
