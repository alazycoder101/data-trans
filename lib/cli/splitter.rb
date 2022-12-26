# frozen_string_literal: true

require 'json'
module CLI
  class Splitter
    attr_reader :max
    attr_reader :base_name

    def initialize(max)
      @records = []
      @index = 0
      @max = max
    end

    def gather(record)
      @records << record

      if @records.count == max
        write_to_file
        @records = []
      end
    end

    def write_to_file
      File.write("chunks_#{@index}.json", JSON.generate(@records))
      @index += 1
    end

    def finalize
      if @records.count > 0
        write_to_file
      end
    end
  end
end
