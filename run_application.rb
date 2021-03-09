# frozen_string_literal: true

begin
  require_relative 'lib/page_views_analyzer'
rescue LoadError => e
  abort "Could not load files #{e}"
end

class RunApplication
  def initialize(file_name)
    @file_name = file_name
  end

  def call
    most_visited_pages, most_unique_visited_pages = ordered_page_view_counts

    PageViewsAnalyzer::Display::MostVisitedPages.new(most_visited_pages).call

    puts '--------------------------------'

    PageViewsAnalyzer::Display::MostUniquelyVisitedPages.new(most_unique_visited_pages).call
  end

  private

  attr_reader :file_name

  def parsed_page_views
    @parsed_page_views ||= PageViewsAnalyzer::Parse::PageViews.new(file_name).call
  end

  def ordered_page_view_counts
    @ordered_page_view_counts ||= PageViewsAnalyzer::CountPageViewsByIp.new(parsed_page_views).call
  end
end
