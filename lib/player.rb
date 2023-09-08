class Player
  attr_reader :name
  attr_accessor :token
  
  def initialize(name, token="")
    @name = name
    @token = token
  end
end