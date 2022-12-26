# frozen_string_literal: true

module CLI
  class EmptyArrayRemover < Processor
    def process(record)
      record.each do |key, val|
        if val.is_a?(Array) && val.empty?
          record.delete(key)
        end
      end
    end
  end
end
