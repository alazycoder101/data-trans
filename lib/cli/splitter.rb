# frozen_string_literal: true

module CLI
  class Splitter
    attr_reader :max
    attr_reader :base_name

    def initialize(max)
      @index = 1
      @max = max
    end

    def gather(record)
      records << record

      if records.count == max
        write_to_file
        records = []
      end
    end

    def write_to_file
      File.write("chunks_#{@index}.json", records.to_json)
    end
  end
end
