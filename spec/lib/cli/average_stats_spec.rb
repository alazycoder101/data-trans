# frozen_string_literal: true

require 'spec_helper'

describe CLI::AverageStats do
  let(:records) do
    [
      { num: 10, name: 'a' },
      { num: 3, name: 'b' },
      { num: 9, name: 'c' }
    ]
  end

  let(:stats) do
    CLI::AverageStats.new('average num', ->(item) { item[:num] })
  end

  describe '#gather' do
    it 'increase count' do
      expect(stats.count).to eq(0)
      stats.gather(records[0])
      expect(stats.count).to eq(1)
    end
  end

  describe '#result' do
    it 'init' do
      expect(stats.result).to eq (0)
    end

    it 'gathers one' do
      records.each do |record|
        stats.gather(record)
      end
      expect(stats.result).to eq(7)
    end
  end
end
