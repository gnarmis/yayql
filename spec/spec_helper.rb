# Ensure that default environment is 'test'
ENV['RACK_ENV'] ||= 'test'

require_relative '../config/boot.rb'

# Ruby's in-built, lightweight, fast testing solution
require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/around/spec'
# stubbing and stuff
require "mocha/mini_test"

