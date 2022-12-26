# frozen_string_literal: true

require 'spec_helper'

describe CLI::Splitter do
  let(:records) do
    [
      { id: 1, num: 10, name: 'a' },
      { id: 3, num: 9, name: 'c' },
      { id: 2, num: 9, name: 'c' }
    ]
  end

  let(:splitter) do
    CLI::Splitter.new(1)
  end

  describe '#collect' do
    it 'call write file' do
      expect(File).to receive(:write)
      splitter.gather(records[0])
    end
  end
end
