# frozen_string_literal: true

require 'json'
module CLI
  class Splitter

    attr_reader :max, :base_name

    def initialize(max, base_name="chunks_")
      @base_name = base_name
      @max = max
      raise 'max should > 0' if max == 0

      @index = 0
      @records = []
    end

    def gather(record)
      @records << record

      if @records.count == max
        write_to_file
        @records = []
      end
    end

    def write_to_file
      while @records.count >= max
        File.write("#{@base_name}#{@index}.json", JSON.generate(@records.slice!(0, max)))
        @index += 1
      end
    end
  end
end
