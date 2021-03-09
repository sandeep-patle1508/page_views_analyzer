# frozen_string_literal: true

require './lib/page_views_analyzer'

describe PageViewsAnalyzer::Parse::PageViews do
  subject(:page_views_parser) { described_class.new(file_name) }

  let(:file_name) { 'spec/support/sample_log_file.log' }
  let(:expected_data) do
    {
      '/help_page/1' => {
        '126.318.035.038' => 3,
        '929.398.951.889' => 1,
        '543.910.244.929' => 1
      },
      '/contact' => {
        '184.123.665.067' => 2
      },
      '/home' => {
        '184.123.665.067' => 1,
        '235.313.352.950' => 1
      },
      '/about/2' => {
        '444.701.448.104' => 1
      },
      '/index' => {
        '444.701.448.104' => 1
      },
      '/about' => {
        '061.945.150.735' => 1
      }
    }
  end

  it 'returns data group by path and associated ip count' do
    expect(page_views_parser.call).to eq(expected_data)
  end

  context 'when file is not exist' do
    let(:file_name) { 'spec/support/random_file.log' }

    it 'raise input file does not found error' do
      expect { page_views_parser.call }.
        to raise_error(
          StandardError,
          'Input file does not found'
        )
    end
  end

  context 'when log file has invalid row' do
    let(:file_name) { 'spec/support/sample_invalid_log_file.log' }

    it 'raise validation error' do
      expect { page_views_parser.call }.
        to raise_error(
          PageViewsAnalyzer::Exceptions::ValidationError,
          '126111.318.035.038 ip format is invalid'
        )
    end
  end
end
