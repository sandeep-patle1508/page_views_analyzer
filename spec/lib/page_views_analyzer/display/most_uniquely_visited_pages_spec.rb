# frozen_string_literal: true

require './lib/page_views_analyzer'

describe PageViewsAnalyzer::Display::MostUniquelyVisitedPages do
  subject { described_class.new(ordered_most_uniquely_visited_pages) }

  let(:ordered_most_uniquely_visited_pages) do
    [
      ['/help_page/1', 3],
      ['/home', 2],
      ['/about', 1],
      ['/index', 1],
      ['/about/2', 1],
      ['/contact', 1]
    ]
  end

  let(:screen_result) do
    "/help_page/1 3 unique views\n" \
    "/home 2 unique views\n/about 1 unique views\n" \
    "/index 1 unique views\n/about/2 1 unique views\n/contact 1 unique views\n"
  end

  it 'returns most visited and uniquely visited pages' do
    expect { subject.call }.to output(screen_result).to_stdout
  end
end
