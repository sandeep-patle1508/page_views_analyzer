# frozen_string_literal: true

require './lib/page_views_analyzer'

describe PageViewsAnalyzer::Display::MostVisitedPages do
  subject { described_class.new(ordered_most_visited_pages) }

  let(:ordered_most_visited_pages) do
    [
      ['/help_page/1', 5],
      ['/home', 2],
      ['/contact', 2],
      ['/about', 1],
      ['/index', 1],
      ['/about/2', 1]
    ]
  end

  let(:screen_result) { "/help_page/1 5 visits\n/home 2 visits\n/contact 2 visits\n/about 1 visits\n/index 1 visits\n/about/2 1 visits\n" }

  it 'returns most visited and uniquely visited pages' do
    expect { subject.call }.to output(screen_result).to_stdout
  end
end
