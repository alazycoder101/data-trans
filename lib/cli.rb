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

    puts args.inspect
    json_file = args[:json_file]
    verbose = args[:verbose]

    processors = []
    fieldRemover = FieldRemover.new('_id')
    emptyArrayRemover = EmptyArrayRemover.new

    bioStripper = FieldStripper.new(:bio, /[^0-9a-z ]/i)

    processors << fieldRemover
    processors << emptyArrayRemover
    processors << bioStripper

    stats = []

    averageFollowedBy = AverageStats.new('followed_by', ->(item) { item[:followed_by] })
    averageMentions = AverageStats.new('mentions', ->(item) { item[:mentions].count})
    mostFollowedUsers = TopStats.new('most_followed_users', ->(item) { [item[:id], item[:followed_by]]})

    stats << averageMentions
    stats << averageFollowedBy
    stats << mostFollowedUsers

    splitter = Splitter.new(100)

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

    splitter.finalize

    if verbose || true
      stats.each { |stat|
        puts stat.name
        puts stat.result
      }
    end
  end
end
