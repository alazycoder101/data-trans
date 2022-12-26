# frozen_string_literal: true

require 'spec_helper'

describe CLI::TopStats do
  let(:records) do
    [
      { id: 1, num: 10, name: 'a' },
      { id: 2, num: 3, name: 'b' },
      { id: 3, num: 9, name: 'c' },
      { id: 2, num: 9, name: 'c' }
    ]
  end

  let(:stats) do
    CLI::TopStats.new('top follower', ->(item) { [item[:id], item[:num]] })
  end

  describe '#result' do
    it 'init' do
      expect(stats.result).to be_nil
    end

    it 'returns first one ' do
      stats.gather(records[0])
      expect(stats.result).to eq([1, 10])
    end

    it 'gathers all' do
      records.each do |record|
        stats.gather(record)
      end
      expect(stats.result).to eq([2, 12])
    end
  end
end
