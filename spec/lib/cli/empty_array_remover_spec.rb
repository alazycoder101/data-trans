# frozen_string_literal: true

require 'spec_helper'

describe CLI::EmptyArrayRemover do
  let(:records) do
    [
      { id: 1, num: [], name: 'a' },
      { id: 2, num: nil, name: 'b' },
      { id: [], num: 9, name: [22] },
      { id: 2, num: 9, name: 'c' }
    ]
  end

  let(:processor) do
    CLI::EmptyArrayRemover.new
  end

  describe '#process' do
    it 'removes empty array' do
      processor.process(records[0])
      expect(records[0][:num]).to be_nil
    end

    it 'does not remove array with elements' do
      processor.process(records[2])
      expect(records[2][:name]).not_to be_nil
    end

    it 'does not remove nil' do
      processor.process(records[2])
      expect(records[1].key?(:num)).to be_truthy
    end
  end
end
