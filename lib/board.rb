module TTT
  class Board
    attr_accessor :positions

    def initialize
      @positions = Array.new(9)
    end

    def add_move(player, position)
      @positions[position] = player 
    end

    def get_player_in_position(position)
      @positions[position]
    end

    def is_move_valid?(move)
      return false unless (0...@positions.length) === move
      return @positions[move] == nil
    end

    def game_over?
      return true if find_winner != nil
      is_board_full?
    end

    def is_a_tie?
      find_winner == nil && is_board_full?
    end

    def find_winner
      winner = nil
      winner = winner || search_for_winner_on_rows 
      winner = winner || search_for_winner_on_columns 
      winner = winner || search_for_winner_on_diagonals 
      winner
    end

    private 
    def search_for_winner_on_rows
      search_for_winner_on_lines(get_rows)
    end

    def search_for_winner_on_columns
      search_for_winner_on_lines(get_cols)
    end

    def search_for_winner_on_diagonals
      search_for_winner_on_lines(get_diagonals)
    end

    def search_for_winner_on_lines(lines)
      winning_line = lines.select do |line|
        line.all?{|element| element==line.first if line.first}
      end
      winning_line[0][0] unless winning_line.empty?
    end

    def get_cols
      get_rows.transpose
    end

    def get_rows
      @positions.each_slice(3).to_a
    end

    def get_diagonals
      diagonal_tl_to_br = [0, 4, 8].map do|index|
        @positions[index]
      end

      diagonal_tr_to_bl = [2, 4, 6].map do|index|
        @positions[index]
      end

      [diagonal_tl_to_br, diagonal_tr_to_bl]
    end

    def is_board_full?
      @positions.all?{|position| position != nil}
    end
  end
end
