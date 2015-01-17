# Setup the basic environment shared by all code in this project

# We'll use the traditional 'development' / 'test' environment approach
ENV["RACK_ENV"] ||= 'development'

APP_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))

# Set up gems listed in the Gemfile, so we can easily require them as needed
require 'rubygems'
ENV['BUNDLE_GEMFILE'] ||= File.join(APP_ROOT, 'Gemfile')
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# add things to the load path
# It's dumb that we have to do this...
$LOAD_PATH << APP_ROOT
$LOAD_PATH << File.join(APP_ROOT, 'spec')

# Get rid of the "NoMethodError: undefined method `callcc' for foo" error
# This usually hides a more interesting error.
require 'continuation'
