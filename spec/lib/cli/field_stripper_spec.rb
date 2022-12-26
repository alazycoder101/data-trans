# frozen_string_literal: true

require 'spec_helper'

describe CLI::FieldStripper do
  let(:records) do
    [
      { id: 1, num: 10, name: 'a' },
      { id: 2, num: 3, name: 'b1234' },
      { id: 3, num: 9, name: 'Cafe 🍳 Bar 🍺 Events 🥂 Ringwood Golf Course 🌿' },
      { id: 2, num: 9, name: 'c' }
    ]
  end

  let(:processor) do
    CLI::FieldStripper.new(:name, /[^0-9a-z ]/i)
  end

  describe '#process' do
    it 'keeps alphabet' do
      processor.process(records[0])
      expect(records[0][:name]).to eq 'a'
    end

    it 'keeps number' do
      processor.process(records[1])
      expect(records[1][:name]).to eq 'b1234'
    end

    it 'strips non alphanumber' do
      processor.process(records[2])
      expect(records[2][:name]).to eq 'Cafe  Bar  Events  Ringwood Golf Course '
    end
  end
end
