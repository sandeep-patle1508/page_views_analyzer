# frozen_string_literal: true

require './run_application'

describe RunApplication do
  subject { described_class.new(input_file_name) }

  let(:input_file_name) { 'spec/support/sample_log_file.log' }

  let(:screen_result) do
    "/help_page/1 5 visits\n/home 2 visits\n/contact 2 visits\n" \
    "/about 1 visits\n/index 1 visits\n/about/2 1 visits\n" \
    "--------------------------------\n" \
    "/help_page/1 3 unique views\n" \
    "/home 2 unique views\n/about 1 unique views\n" \
    "/index 1 unique views\n/about/2 1 unique views\n/contact 1 unique views\n"
  end

  it 'display result on the screen' do
    expect { subject.call }.to output(screen_result).to_stdout
  end

  context 'when input log file does not exist' do
    let(:input_file_name) { 'spec/support/wrong_input_file.log' }

    it 'raise file does not exist error' do
      expect { subject.call }.to raise_error('Input file does not found')
    end
  end

  context 'when input log file has invalid data' do
    let(:input_file_name) { 'spec/support/sample_invalid_log_file.log' }

    it 'raise validation error' do
      expect { subject.call }.
        to raise_error(PageViewsAnalyzer::Exceptions::ValidationError,
                       '126111.318.035.038 ip format is invalid')
    end
  end
end
