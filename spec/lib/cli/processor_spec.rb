# frozen_string_literal: true

require 'spec_helper'
describe CLI::Remover do
  let(:processor) { CLI::Remover.new }

  describe 'initialize' do
    it 'should create a new Parser object' do
      processor = CLI::Processor.new
      expect(processor).to be_a CLI::Processor
    end
  end

  describe '#process' do
    it 'should parse a log file' do
      expect(processor.process(row)).to be_a Hash
    end
  end
end
