# frozen_string_literal: true

require 'fast_jsonparser'
require 'benchmark'
# CLI: command line
module CLI
  #Dir['lib/cli/**/*.rb'].each { |f| puts f; require_relative "../#{f}" }
  require_relative 'cli/processor'
  require_relative 'cli/empty_array_remover'
  require_relative 'cli/field_remover'
  require_relative 'cli/field_stripper'

  require_relative 'cli/average_stats'
  require_relative 'cli/top_stats'

  require_relative 'cli/splitter'

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

    processed = 0

    # batch_size can be changed base on chunk size
    report = Benchmark.measure {

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
          processed += 1
        }
      }

      splitter.write_to_file
    }

    if verbose
      stats.each { |stat|
        puts "#{stat.name}: #{stat.result}"
      }
      puts ''
      puts "#{processed} records are processed"
      puts report.to_s
    end
  end
end
