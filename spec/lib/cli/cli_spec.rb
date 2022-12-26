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

    context 'wit file' do
      it 'should print stats' do
        output = <<~OUTPUT
          /about/2 90 visits
          /contact 89 visits
          /index 82 visits
        OUTPUT

        expect do
          CLI.run ['spec/fixtures/webserver.log']
        end.to output(a_string_including(output)).to_stdout
      end

      it 'should print unique stats' do
        output = <<~OUTPUT
          /about/2 22 visits
          /about 21 visits
        OUTPUT
        expect do
          CLI.run ['spec/fixtures/webserver.log']
        end.to output(a_string_including(output)).to_stdout
      end
    end
  end

  describe '#version' do
    it 'shoud return the version' do
      expect(CLI.version).to eq('0.0.1')
    end
  end
end
