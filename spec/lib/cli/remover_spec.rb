# frozen_string_literal: true

require 'spec_helper'
describe CLI::Processor do
  let(:remover) { CLI::Remover.new }

  describe '#process' do
    it 'should remove the filed' do
      expect(processor.process(row)).to be_a Hash
    end
  end
end
