# frozen_string_literal: true

require './lib/page_views_analyzer'

describe PageViewsAnalyzer::Parse::PageView do
  subject { described_class.new(line_string) }

  let(:line_string) { '/example_path 111.222.333.444' }

  let(:expected_result) { %w[/example_path 111.222.333.444] }

  it 'returns expected array of parsed path and ip' do
    expect(subject.call).to eq(expected_result)
  end
end
