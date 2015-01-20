require_relative '../lib/game_factory.rb'
require_relative 'utils/fake_display.rb'

describe TTT::Main do
  let(:renderer) { TTT::FakeDisplay.new }

  it 'run through hvh game where player X wins' do
    renderer.set_user_input('0', '1','2','3','4','5','6','7','8')
    game = TTT::GameFactory.new(renderer).build_hvh_game
    expect(renderer.get_previous_renders).to include('X has won.')
  end

  #it 'run through game where there is a tie' do
    #renderer.set_user_input('0','1','2','3','5','4','7','8','6')
    #TTT::Main.new(renderer).run
    #expect(renderer.get_previous_renders).to include('Game is a tie.')
  #end

end
