module TTT
  class StubPlayer
    attr_accessor :mark

    def initialize
      @mark = generate_random_mark
    end

    def generate_random_mark
      rand(100).chr 
    end
  end
end
