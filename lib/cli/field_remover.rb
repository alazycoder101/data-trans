# frozen_string_literal: true

module CLI
  # remove specific field
  class FieldRemover < Processor
    attr_reader :name

    def initialize(name)
      @name = name.to_sym
    end

    def process(fields)
      fields.delete(name)
    end
  end
end
