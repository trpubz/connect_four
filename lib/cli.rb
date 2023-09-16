module CLI
  def self.get_input
    STDIN.gets.chomp.upcase
  end

  def self.clear
    system("clear")
  end
end
