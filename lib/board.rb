require 'json'

module TTT
  class Board

    attr_reader :row_size
    attr_reader :positions

    def self.new_board_with_positions(positions)
      row_size = Math.sqrt(positions.size)
      Board.new(row_size, positions)
    end

    def initialize(row_size, positions=nil)
      @row_size = row_size

      if positions.nil?
        @positions = Array.new(row_size ** 2)
      else
        @positions = positions
      end
    end

    def num_of_occupied_positions
      @positions.size - empty_positions.size
    end

    def get_mark_at_position(position)
      positions[position]
    end

    def copy
      Board.new(@row_size, positions.dup)
    end

    def empty_positions
      position_indexes = positions.map.with_index do |position, index|
        index if position.nil?
      end
      position_indexes.reject{|element| element.nil?}
    end

    def add_move(mark, position)
      positions[position] = mark
    end

    def is_move_valid?(move)
      return false unless (0...positions.length) === move
      return positions[move].nil?
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
      positions.each_slice(@row_size).to_a
    end

    def number_of_positions
      positions.size
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
      positions.all?{|position| position != nil}
    end

    private

  end
end
