require 'data_science/json_parser'

module DataScience
  describe JsonParser do
    describe '.parse_file' do
      let(:sample_file) { File.join(File.dirname(__FILE__), 'source_data_test.json') }

      it "parses a JSON file" do
        expect(JsonParser.parse_file(sample_file).size).to eq(4)
      end
    end
  end
end
