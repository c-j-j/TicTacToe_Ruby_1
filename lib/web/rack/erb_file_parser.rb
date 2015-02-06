require 'erb'

module TTT
  module Web
      class ERBFileParser
        def parse(file, variables=nil)
          renderer = ERB.new(File.new(file, "r").read)
          renderer.result(binding)
        end
      end
    end
  end
