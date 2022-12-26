# frozen_string_literal: true

module CLI
  class FieldRemover < Processor
    def initialize(name)
      @name = name
    end

    def process(record)
      reocrd.excpet(name)
    end
  end
end
