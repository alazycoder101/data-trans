# frozen_string_literal: true

require 'debug'
require 'fast_jsonparser'
# CLI: command line
module CLI
  #Dir['lib/cli/**/*.rb'].each { |f| puts f; require_relative "../#{f}" }
  require_relative 'cli/processor'
  require_relative 'cli/empty_array_remover'
  require_relative 'cli/field_remover'
  require_relative 'cli/average_stats'
  require_relative 'cli/top_stats'
  require_relative 'cli/splitter'
  require_relative 'cli/field_stripper.rb'

  module_function

  def run(args = {})

    json_file = args[:json_file]
    verbose = args[:verbose]
    max_records = args[:max] || 100

    processors = []
    processors << FieldRemover.new('_id')
    processors << EmptyArrayRemover.new
    processors << FieldStripper.new(:bio, /[^0-9a-z ]/i)

    stats = []

    stats << AverageStats.new('followed_by', ->(item) { item[:followed_by] })
    stats << AverageStats.new('mentions', ->(item) { item[:mentions].count})
    stats << TopStats.new('most_followed_users', ->(item) { [item[:id], item[:followed_by]]})

    splitter = Splitter.new(max_records.to_i)

    # batch_size can be changed base on chunk size
    FastJsonparser.load_many(json_file, batch_size: 9100_000) { |items|
      items.each { |item|
        # stats
        stats.each do |stat|
          stat.gather(item)
        end

        # process
        processors.each do |proccessor|
          proccessor.process(item)
        end

        splitter.gather(item)
      }
    }

    splitter.write_to_file

    if verbose
      stats.each { |stat|
        puts "#{stat.name}: #{stat.result}"
      }
    end
  end
end
