require_relative '../lib/display.rb'

describe TTT::Display do
  FAKE_USER_INPUT = "some user input"
  let(:output) { StringIO.new }
  let(:input) { StringIO.new("#{FAKE_USER_INPUT}\n") }
  let(:renderer) { TTT::Display.new(input, output) }

  it 'outputs to screen when render is called' do
    output_string = "some string"
    renderer.render(output_string)
    expect(output.string).to eq("%s\n" % output_string) 
  end

  it 'grabs and chomps user input' do
    expect(renderer.get_user_input).to eq(FAKE_USER_INPUT)
  end

end
