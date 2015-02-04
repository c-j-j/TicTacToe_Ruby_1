require 'web/rack/erb_file_parser'
require 'erb'
describe TTT::Web::Rack::ERBFileParser do
  let(:erb_file_parser) { TTT::Web::Rack::ERBFileParser.new }
  it 'parses file without parsing variables' do
    file = filepath('test_data/no_variables.erb')
    parsed_string = erb_file_parser.parse(file)
    expect(parsed_string).to eq("hello, world!\n")
  end

  it 'parses file with variables' do
   file = filepath('test_data/with_variables.erb')
   variables = {'name' => 'Chris'}
   parsed_string = erb_file_parser.parse(file, variables)
   expect(parsed_string).to eq("my name is Chris.\n")
  end

  def filepath(relative_path)
    File.join(File.dirname(__FILE__), relative_path)
  end
end
