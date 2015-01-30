require 'qt'

module TTT
  class QT_Interface < Qt::Widget
    attr_reader :cells
    def initialize
      super
      @cells = []
      init_screen
      show
    end

    def init_screen
      setWindowTitle "Tic Tac Toe"
      print_board
    end

    def register_game(game)
      @game = game
    end

    def register_move(position)
      @game.register_move(position)
    end

    def play
      @game.game_over?
    end

    private

    def print_board
      grid = Qt::GridLayout.new(self)
      0.upto(2) do |row|
        0.upto(2) do |column|
          cell = Qt::Label.new '-'
          grid.addWidget(cell, row, column)
          @cells << cell
        end
      end
    end
  end
end

#app = Qt::Application.new ARGV
#TTT::QT_Interface.new(nil)
#app.exec
