# frozen_string_literal: true

if ENV.fetch('COVERAGE', false)
  require 'simplecov'
  SimpleCov.start do
    add_filter '/spec/'
    minimum_coverage 90
    maximum_coverage_drop 2
  end
end

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'cli'
