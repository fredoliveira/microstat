Gem::Specification.new do |s|
  s.name        = 'microstat'
  s.version     = '0.0.1'
  s.date        = '2016-11-22'
  s.summary     = "A tiny library for event statistics in apps."
  s.description = "Microstat is a library to capture events and compile statistics on those events in an application. Like a micro Mixpanel."
  s.authors     = ["Fred Oliveira"]
  s.email       = 'fred@helloform.com'
  s.files       = ["lib/microstat.rb"]
  s.homepage    = 'http://rubygems.org/gems/microstat'
  s.license     = 'MIT'

  s.add_runtime_dependency 'redis', '~>3.2'
end
