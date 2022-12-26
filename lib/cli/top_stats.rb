# frozen_string_literal: true

module CLI
  class TopStats
    def initialize(block)
      @stats = {}
      @block = block
    end

    def gather(record)
      record = block.call(record)

      @stats[record[0]] ||= 0
      @stats[record[0]] += record[1]
    end

    def result
      @stats.max_by{|val| val}
    end
  end
end
