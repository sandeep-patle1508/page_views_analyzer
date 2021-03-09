# frozen_string_literal: true

module PageViewsAnalyzer
  class CountPageViewsByIp
    def initialize(path_with_visited_ips)
      @path_with_visited_ips = path_with_visited_ips
      @most_visited_pages = {}
      @most_unique_visited_pages = {}
    end

    def call
      path_with_visited_ips.each do |path, ip_counts|
        @most_visited_pages[path] = ip_counts.values.sum
        @most_unique_visited_pages[path] = ip_counts.keys.count
      end

      [
        sort_by_value(most_visited_pages),
        sort_by_value(most_unique_visited_pages)
      ]
    end

    private

    attr_reader :path_with_visited_ips
    attr_accessor :most_visited_pages, :most_unique_visited_pages

    def sort_by_value(visited_pages_counter)
      visited_pages_counter.sort_by { |_, v| v }.reverse
    end
  end
end
