# frozen_string_literal: true

require 'spec_helper'

describe CLI::FieldRemover do
  let(:records) do
    [
      { id: 1, num: 10, name: 'a' },
      { id: 2, num: 3, name: 'b' },
      { id: 3, num: 9, name: 'c' },
      { id: 2, num: 9, name: 'c' }
    ]
  end

  let(:processor) do
    CLI::FieldRemover.new('id')
  end

  describe '#process' do
    it 'returns first one ' do
      processor.process(records[0])
      expect(records[0][:id]).to be_nil
    end
  end
end
