# frozen_string_literal: true

require 'debug'
# CLI: command line
module CLI
  #Dir['lib/cli/**/*.rb'].each { |f| puts f; require_relative "../#{f}" }
  require_relative 'cli/processor'
  require_relative 'cli/empty_remover'
  require_relative 'cli/field_remover'
  require_relative 'cli/average_stats'
  require_relative 'cli/top_stats'
  require_relative 'cli/splitter'
  require_relative 'cli/field_stripper.rb'

  module_function

  def run(args = [])
    processors = []

    fieldRemover = FieldRemover.new('_oid')
    emptyArrayRemover = EmptyArrayRemover.new

    bioStripper = FieldStripper.new(:bio, Regex.new())

    processors << fieldRemover
    processors << emptyFieldRemover

    stats = []

    averageFollowedBy = AverageStats.new('followed_by', ->(item) { item[:followed_by].count})
    averageMentions = AverageStats.new('mentions', ->(item) { item[:mentions].count})
    mostFollowedUsers = TopStats.new('most_folloed_users', ->(item) { item[:id]})

    splitter = Splitter.new(max)

    FastJsonparser.load_many(file_path) { |item|
      # stats
      stats.each do |stat|
        stats.gather(item)
      end

      # process
      processors.each do |proccessor|
        proccessor.process(item)
      end

      splitter.collect(item)
    }

    splitter.finalize
  end
end
