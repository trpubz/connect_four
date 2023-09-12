class Player
  attr_reader :name
  attr_accessor :token
  
  def initialize(name, token="X")
    @name = name
    @token = token
  end
end