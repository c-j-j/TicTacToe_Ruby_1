module TTT
  class GameInformation < Struct.new(:board, :status, :winner, :current_player_mark, :current_player_is_computer, :row_size)
  end
end
