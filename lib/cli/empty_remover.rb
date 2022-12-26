# frozen_string_literal: true

module CLI
  class Remover < Processor
    def process(record)
      record.each do |key, val|
        if val.is_a?(Array) && val.empty?
          record.del(key)
        end
      end
    end
  end
end
