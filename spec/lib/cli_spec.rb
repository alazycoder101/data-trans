# frozen_string_literal: true

require 'spec_helper'
describe CLI do
  describe '#run' do
    context 'without arguments' do
      it 'should print help' do
        expect do
          CLI.run
        end.to output(a_string_including('Usage:')).to_stdout
      end
    end

    context 'with file' do
      it 'should create files' do
        expect do
          CLI.run({json_file: 'spec/fixtures/one.json'})
        end.to output(a_string_including(output)).to_stdout
      end
    end
  end
end
