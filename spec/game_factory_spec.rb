require_relative '../lib/game_factory.rb'
require_relative 'stubs/stub_display.rb'

describe TTT::GameFactory do
  let(:display) { TTT::StubDisplay.new }
  let(:game_factory) { TTT::GameFactory.new(display) }

  it 'builds hvh game based on user input' do
    display.specify_game_type('1')
    game = game_factory.build_game_for_user
    expect(game.player_1).to be_kind_of(TTT::HumanPlayer)
    expect(game.player_2).to be_kind_of(TTT::HumanPlayer)
  end

  it 'builds hvc game based on user input' do
    display.specify_game_type('2')
    game = game_factory.build_game_for_user
    expect(game.player_1).to be_kind_of(TTT::ComputerPlayer)
    expect(game.player_2).to be_kind_of(TTT::ComputerPlayer)
  end

  it 'builds hvc game based on user input' do
    display.specify_game_type('3')
    game = game_factory.build_game_for_user
    expect(game.player_1).to be_kind_of(TTT::HumanPlayer)
    expect(game.player_2).to be_kind_of(TTT::ComputerPlayer)
  end

  it 'builds cvh game based on user input' do
    display.specify_game_type('4')
    game = game_factory.build_game_for_user
    expect(game.player_1).to be_kind_of(TTT::ComputerPlayer)
    expect(game.player_2).to be_kind_of(TTT::HumanPlayer)
  end
end
