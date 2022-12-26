# frozen_string_literal: true
module CLI
  # average stats
  class AverageStats
    attr_reader :count
    def initialize(name, block)
      @name = name
      @block = block
      @sum = 0
      @count = 0
    end

    def gather(record)
      @sum += @block.call(record)
      @count += 1
    end

    def result
      return 0 if @count.zero?

      @sum / @count
    end
  end
end
