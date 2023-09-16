Gem::Specification.new do |s|
  s.name          = "connect_cuatro"
  s.version       = "0.3.0"
  s.platform      = Gem::Platform::RUBY
  s.summary       = "Connect Four -- Turing School of Software & Design -- Mod1 Project"
  s.description   = "Digital version of the Classic Connect Four boardgame."
  s.authors       = ["Matt Darlington", "Taylor Pubins"]
  s.email         = ["matthewsdarlington@gmail.com", "tpubz@icloud.com"]
  s.homepage      = "http://rubygems.org/gems/connect_cuatro"
  s.license       = "MIT"
  s.files         = Dir.glob("{lib,bin}/**/*") # This includes all files under the lib directory recursively, so we don't have to add each one individually.
  s.require_path  = "lib"
  s.executables   = ["connect_cuatro"]
end
