require 'tk'
require 'tkextlib/tile'

module TTT
  class TkInterface
    def initialize
      create_gui
      Tk.mainloop
    end

    def create_gui
      @root = TkRoot.new{title "Tic Tac Toe"}
      ph = {'padx'=>50, 'pady'=>30}
      @content = Tk::Tile::Frame.new(@root) {padding "3 3 12 12"}.grid( :sticky => 'nsew')
      Tk::Tile::Label.new(@content) {width 7; text 'Starting'; pack(ph)}.grid( :column => 2, :row => 2, :sticky => 'we');
      #$text_to_display.value = "Game has ended in a draw"
    end

    def print_tie_message
      @label['text'] = 'changd'
      $text_to_display.value = "Game has ended in a draw"
    end
  end
end

TTT::TkInterface.new.print_tie_message

#content = Tk::Tile::Frame.new(root) {padding "3 3 12 12"}.grid( :sticky => 'nsew')
#p = Tk::Tile::Paned.new(root)

##Tk::Tile::Labelframe.new(content) { text 'Board' }
#button_a = Tk::Tile::Button.new(content) {text '-'; width 3; command {calculate}}.grid( :column => 1, :row => 1)
#button = Tk::Tile::Button.new(content) {text '-'; width 3;command {calculate} }.grid( :column => 1, :row => 2)
#button = Tk::Tile::Button.new(content) {text '-'; width 3;command {calculate} }.grid( :column => 1, :row => 3)
#button = Tk::Tile::Button.new(content) {text '-'; width 3;command {calculate} }.grid( :column => 2, :row => 1)
#button = Tk::Tile::Button.new(content) {text '-'; width 3;command {calculate} }.grid( :column => 2, :row => 2)
#button = Tk::Tile::Button.new(content) {text '-'; width 3;command {calculate} }.grid( :column => 2, :row => 3)
#button = Tk::Tile::Button.new(content) {text '-'; width 3;command {calculate} }.grid( :column => 3, :row => 1)
#button = Tk::Tile::Button.new(content) {text '-'; width 3;command {calculate} }.grid( :column => 3, :row => 2)
#button = Tk::Tile::Button.new(content) {text '-'; width 3;command {calculate} }.grid( :column => 3, :row => 3)
#Tk::Tile::Label.new(content) {text 'X\'s go'}.grid( :column => 1, :row => 4, :sticky => 'w')

#content_2 = Tk::Tile::Frame.new(root) {padding "3 3 12 12"}.grid( :sticky => 'nsew')
#Tk::Tile::Labelframe.new(content_2) { text 'Input' }
#button_b = Tk::Tile::Button.new(content) {text 'Hello' ; command{calculate} }.grid( :column => 1, :row => 1)

#button_a.state('disabled')
#def calculate
#content.unpack
#end

#Tk.mainloop

