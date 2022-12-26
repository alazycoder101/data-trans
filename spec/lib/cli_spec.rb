# frozen_string_literal: true

require 'spec_helper'
describe CLI do
  describe '#run' do
    context 'with file' do
      it 'should output stats details with one json file' do
        expect do
          CLI.run({json_file: 'spec/fixtures/one.json', verbose: true})
        end.to output(a_string_including('followed_by: 653')).to_stdout

        json = JSON.parse(File.read('chunks_0.json'), symbolize_names: true)
        expect(json[0][:hash_tag]).to be_nil
        expect(json[0][:_oid]).to be_nil
        expect(json[0][:id]).not_to be_nil
      end

      it 'should output average stats details' do
        expect do
          CLI.run({json_file: 'spec/fixtures/10.json', verbose: true})
        end.to output(a_string_including("most_followed_users: [\"49686101\", 12573]")).to_stdout

        json = JSON.parse(File.read('chunks_0.json'), symbolize_names: true)
        expect(json[0][:hash_tag]).to be_nil
        expect(json[0][:_oid]).to be_nil
        expect(json[0][:id]).not_to be_nil
      end
    end
  end
end
