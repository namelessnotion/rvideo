Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'rvideo'
  s.version     = '0.9.7'
  s.summary     = 'Just a gemspec for bundler to install via git'
  s.description = 'Forked RVideo - https://github.com/namelessnotion/rvideo'

  s.required_ruby_version     = '>= 1.9.2'
  s.required_rubygems_version = ">= 1.8.10"

  s.author            = 'Anthony Byram'
  s.email             = 'anthony@namelessnotion.com'
  s.homepage          = 'https://github.com/namelessnotion/rvideo'

  s.files              = Dir.glob("{bin,lib}/**/*")

  s.add_dependency('i18n')
  s.add_dependency('activesupport')
  s.add_dependency('open4')
end

