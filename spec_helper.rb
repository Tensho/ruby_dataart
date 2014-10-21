require 'bundler/setup'
Bundler.require :test

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use! Minitest::Reporters::RubyMineReporter.new
