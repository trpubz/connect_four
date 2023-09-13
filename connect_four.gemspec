Gem::Specification.new do |s|
  s.name      = 'connect_four'
  s.version   = '1.0.0'
  s.platform  = Gem::Platform::RUBY
  s.summary   = 'Matt and Taylor\'s Connect Four Turing School project'
  s.description = "Digital version of the Classic Connect Four boardgame, played against a non-living, semi-smack-talking AI-ish opponent."
  s.authors   = ['Matt Darlington', 'Taylor Pubins']
  s.email     = ['matthewsdarlington@gmail.com']
  s.homepage  = 'http://rubygems.org/gems/connect_four_mdtp'
  s.license   = 'MIT'
  s.files     = Dir.glob("{lib,bin}/**/*") # This includes all files under the lib directory recursively, so we don't have to add each one individually.
  s.require_path = 'lib'
  s.executables = ['connect']
end