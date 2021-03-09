# frozen_string_literal: true

require './lib/page_views_analyzer'

RSpec.shared_examples 'should raise validation error' do
  it 'raises validation error' do
    expect { subject.call }.
      to raise_error(PageViewsAnalyzer::Exceptions::ValidationError, error_message)
  end
end

describe PageViewsAnalyzer::Parse::PageView do
  subject { described_class.new(line_string) }

  let(:line_string) { '/example_path 111.222.333.444' }

  let(:expected_result) { %w[/example_path 111.222.333.444] }

  it 'returns expected array of parsed path and ip' do
    expect(subject.call).to eq(expected_result)
  end

  context 'when input log data is invalid' do
    context 'when path is blank' do
      let(:line_string) { '' }
      let(:error_message) { 'path can not be blank' }

      include_examples 'should raise validation error'
    end

    context 'when ip is blank' do
      let(:line_string) { '/example_path' }
      let(:error_message) { 'ip can not be blank' }

      include_examples 'should raise validation error'
    end

    context 'when path does not start with /' do
      let(:line_string) { 'example_path 111.222.333.444' }
      let(:error_message) { 'path must start with /' }

      include_examples 'should raise validation error'
    end

    context 'when path does not start with /' do
      let(:line_string) { '/example_path 111.222.333.4445' }
      let(:error_message) { 'ip format is invalid' }

      include_examples 'should raise validation error'
    end
  end
end
