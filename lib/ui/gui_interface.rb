require 'qt'
require 'lib/ui/gui_board_cell'
require 'tictactoe_game'

module TTT
  module UI
    class GUIInterface < Qt::Widget
      attr_reader :cells
      attr_reader :status_label
      attr_reader :game_state
      attr_reader :play_button
      attr_reader :game_choices
      attr_reader :game_sizes
      attr_reader :next_game_type_to_build
      attr_reader :next_board_size_to_build
      attr_reader :ui_grid

      #registers functions so GUI can call them
      START_GAME_FUNCTION = "start_game()"
      PREPARE_GAME_TYPE_FUNCTION = 'prepare_next_game_type_to_create(QString)'
      PREPARE_BOARD_SIZE_FUNCTION = "prepare_board_size(QString)"
      slots START_GAME_FUNCTION
      slots PREPARE_GAME_TYPE_FUNCTION
      slots PREPARE_BOARD_SIZE_FUNCTION

      WINNING_MESSAGE = "%s has won"
      DRAW_MESSAGE = 'Draw'
      NEXT_PLAYER_TO_GO_MESSAGE = "%s's turn"
      INVALID_MOVE_MESSAGE = 'Invalid move'
      TOP_PADDING = 1

      def initialize(game = nil)
        super(nil)
        @game_state = :INITIAL
        @next_game_type_to_build = TTT::Game.default_game_type
        @next_board_size_to_build = TTT::Game.default_board_size
        @game = game
        init_screen
        show
      end

      def init_screen
        @ui_grid = Qt::GridLayout.new(self)
        setWindowTitle("Tic Tac Toe")
        resize(600, 600)
        create_widgets
        position_widgets
      end

      def board_clicked(position)
        return if @game_state != :AWAITING_USER_MOVE

        if !@game.move_valid?(position)
          print_invalid_move_message
          return
        end

        update_game_state(:IN_PROGRESS)
        @game.continue_game_with_move(position)
      end

      #TODO unable to unit test as is
      def start_game
        create_new_game
        init_board
        @game.play
      end

      def print_next_player_to_go(mark)
        update_status(NEXT_PLAYER_TO_GO_MESSAGE % mark)
      end

      def print_winner_message(mark)
        update_status(WINNING_MESSAGE % mark)
        end_game
      end

      def print_tie_message
        update_status(DRAW_MESSAGE)
        end_game
      end

      def print_invalid_move_message
        update_status(INVALID_MOVE_MESSAGE)
      end

      def print_board(board)
        cells.each_with_index do |cell, index|
          cell.text = board.get_mark_at_position(index)
        end
      end

      def get_user_move(_)
        update_game_state(:AWAITING_USER_MOVE)
        TTT::Game::MOVE_NOT_AVAILABLE
      end

      def prepare_next_game_type_to_create(game_type)
        @next_game_type_to_build = game_type
      end

      def prepare_board_size(board_size)
        @next_board_size_to_build = board_size
      end

      def init_board
        clear_board unless @cells.nil?
        @cells = []
        (0...board_size).each do |cell_index|
          cell = TTT::UI::GUIBoardCell.new(self, cell_index)
          row, column = get_row_and_column_from_index(cell_index)
          @ui_grid.addWidget(cell, row + TOP_PADDING, column)
          @cells << cell
        end
      end

      def create_new_game
        @game = TTT::Game.build_game(self, @next_game_type_to_build, @next_board_size_to_build.to_i)
      end

      private

      def create_widgets
        @status_label = Qt::Label.new("Press play to begin", self)
        @play_button = Qt::PushButton.new('Play', self)
        register_button_press(@play_button, START_GAME_FUNCTION)
        @game_choices = create_game_choices_combo_box
        @game_sizes = create_game_size_combo_box
      end

      def position_widgets
        @ui_grid.addWidget(@game_choices, 0, 0)
        @ui_grid.addWidget(@game_sizes, 0, 1)
        @ui_grid.addWidget(@play_button, 0, 2)
        @ui_grid.addWidget(@status_label, 5, 0)
      end

      def clear_board
        @cells.each do |cell|
          cell.hide
          @ui_grid.removeWidget(cell)
        end
      end

      def create_game_choices_combo_box
        create_combo_box(TTT::Game::GAME_TYPES, PREPARE_GAME_TYPE_FUNCTION)
      end

      def create_game_size_combo_box
        create_combo_box(TTT::Game::BOARD_SIZES, PREPARE_BOARD_SIZE_FUNCTION)
      end

      def create_combo_box(choices, select_function)
        selection_menu = Qt::ComboBox.new(self)
        choices.each {|choice| selection_menu.addItem(choice.to_s) }

        connect(selection_menu, SIGNAL("activated(QString)"), self, SLOT(select_function))
        selection_menu
      end

      def register_button_press(button, function)
        connect(button, SIGNAL(:pressed), self, SLOT(function))
      end

      def update_status(message)
        @status_label.text = message
      end

      def get_row_and_column_from_index(cell_index)
        cell_index.divmod(@game.row_size)
      end

      def board_size
        @game.number_of_positions
      end

      def update_game_state(state)
        @game_state = state
      end

      def end_game
        update_game_state(:GAME_OVER)
      end
    end
  end
end
