require 'game'

module TTT
  class AsyncInterface
   def get_user_move(_)
     Game::MOVE_NOT_AVAILABLE
   end
  end
end
