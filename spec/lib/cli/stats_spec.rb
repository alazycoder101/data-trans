# frozen_string_literal: true

require 'spec_helper'
describe CLI::Counter do
  let(:rows) do
    [
      CLI::Row.new('/help_page/1', '126.318.035.038'),
      CLI::Row.new('/contact', '184.123.665.067'),
      CLI::Row.new('/home', '184.123.665.067'),
      CLI::Row.new('/about/2', '444.701.448.104'),
      CLI::Row.new('/help_page/1', '929.398.951.889'),
      CLI::Row.new('/help_page/1', '126.318.035.038'),
      CLI::Row.new('/help_page/1', '722.247.931.582')
    ]
  end

  describe '#count' do
    it 'should return visits' do
      result = CLI::Counter.count(rows)
      expect(result[0]).to eq(['/help_page/1', 4])
    end

    it 'should return unique visits' do
      result = CLI::Counter.unique_count(rows)
      expect(result[0]).to eq(['/help_page/1', 3])
    end
  end
end
