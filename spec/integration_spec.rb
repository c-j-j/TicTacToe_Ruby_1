require_relative '../lib/main.rb'
require_relative 'utils/fake_cli_renderer.rb'

describe TTT::Main do
  let(:renderer) { TTT::Fake_CLI_Renderer.new }

  it 'run through game where player X wins' do
    renderer.set_user_input('0', '1','2','3','4','5','6','7','8')
    TTT::Main.new(renderer).run
    expect(renderer.get_previous_renders).to include('X has won.')
  end

  it 'run through game where there is a tie' do
    renderer.set_user_input('0','1','2','3','5','4','7','8','6')
    TTT::Main.new(renderer).run
    expect(renderer.get_previous_renders).to include('Game is a tie.')
  end

end
