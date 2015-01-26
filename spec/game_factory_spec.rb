require_relative '../lib/game_factory.rb'
require_relative 'stubs/stub_display.rb'

describe TTT::GameFactory do
  let(:display) { TTT::StubDisplay.new }
  let(:game_factory) { TTT::GameFactory.new(display) }

  it 'builds hvc game based on user input' do
    display.specify_game_type(:HVC)

    game = game_factory.build_game_for_user
    expect(game.current_player).to be_kind_of(TTT::HumanPlayer)
  end

  it 'builds hvc game where user states for computer to go first' do
    display.specify_game_type(:HVC)
    display.specify_first_player(:computer)
    game = game_factory.build_game_for_user
    expect(game.current_player).to be_kind_of(TTT::ComputerPlayer)
  end
end
