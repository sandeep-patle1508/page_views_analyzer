# frozen_string_literal: true

require './lib/page_views_analyzer'

describe PageViewsAnalyzer::CountPageViewsByIp do
  subject { described_class.new(path_with_visitor_ips) }

  let(:path_with_visitor_ips) do
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
        '235.313.352.950'=> 1
      },
      '/about/2' => {
        '444.701.448.104' => 1
      },
      '/index' => {
        '444.701.448.104' => 1
      },
      '/about' => {
        '061.945.150.735'=> 1
      }
    }
  end

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

  let(:ordered_most_uniquely_pages) do
    [
      ['/help_page/1', 3],
      ['/home', 2],
      ['/about', 1],
      ['/index', 1],
      ['/about/2', 1],
      ['/contact', 1]
    ]
  end

  it 'returns array of most visited and uniquely visited pages' do
    expect(subject.call).
      to match_array(
           [
             ordered_most_visited_pages,
             ordered_most_uniquely_pages
           ]
         )
  end
end
