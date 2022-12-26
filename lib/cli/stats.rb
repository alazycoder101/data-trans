# frozen_string_literal: true

module CLI
  # Counter: count visits to paths
  class Counter
    attr_reader :stats

    def self.count(rows)
      counter = Counter.new(rows)
      counter.count
    end

    def self.unique_count(rows)
      counter = Counter.new(rows)
      counter.unique
    end

    def initialize(rows = [])
      @rows = rows
    end

    def count
      group.map { |variable| [variable[0], variable[1].size] }
    end

    def group
      @group ||= @rows.group_by { |row| row.fields[0] }
    end

    def unique
      group.map do |variable|
        [variable[0], variable[1].map do |row|
                        row.fields[1]
                      end.uniq.size]
      end
    end
  end
end
