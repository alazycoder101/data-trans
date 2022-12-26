# frozen_string_literal: true

module CLI
  class FieldStripper < Processor
    def initialize(name, regex)
      @name = name
      @regex = regex
    end

    def process(record)
      record[@name] = record[@name].gsub(@regex, '')
    end
  end
end
