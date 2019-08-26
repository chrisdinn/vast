require 'simplecov'
SimpleCov.start

require 'test/unit'
require 'rubygems'
require 'bundler'

Bundler.setup(:default, :test)
Bundler.require(:default, :test)

require 'vast'

def example_file(filename)
  file_path = File.expand_path(File.join(File.dirname(__FILE__), 'examples', filename))
  File.read file_path
end
