#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'cli'
require 'optparse'

@options = {}
OptionParser.new do |opts|
  opts.on("-v", "--verbose", "Show extra information") do
    @options[:verbose] = true
  end
  opts.on("-c", "--color", "Enable syntax highlighting") do
    @options[:syntax_highlighting] = true
  end
end.parse!

p @options
CLI.run(@options)
