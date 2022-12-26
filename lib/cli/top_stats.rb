# frozen_string_literal: true

module CLI
  class TopStats
    attr_reader :name
    def initialize(name, block)
      @name = name
      @stats = {}
      @block = block
    end

    def gather(record)
      record = @block.call(record)

      @stats[record[0]] ||= 0
      @stats[record[0]] += record[1]
    end

    def result
      @stats.max_by{|key, val| val}
    end
  end
end
