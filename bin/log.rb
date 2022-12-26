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
  opts.on("-fFILE", "--file=FILE", "JSON file") do |file|
    @options[:json_file] = file
  end
end.parse!

puts @options.inspect

CLI.run(@options)
