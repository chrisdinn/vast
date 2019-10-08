# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'vast/version'

Gem::Specification.new do |s|
  s.name        = "vast"
  s.version     = Vast::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Chris Dinn"]
  s.email       = ["chrisgdinn@gmail.com"]
  s.homepage    = "http://github.com/chrisdinn/vast"
  s.summary     = "A gem for working with VAST 2.0 documents"
  s.license     = "MIT"

  s.files       = Dir.glob('lib/**/*') + %w(LICENSE README.rdoc CHANGELOG.md)
  s.require_path = 'lib'

  s.add_dependency 'nokogiri', '~> 1.5'

  s.add_development_dependency 'gem-release'
  s.add_development_dependency 'pathological'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'test-unit'
end
