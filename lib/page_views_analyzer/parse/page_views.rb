# frozen_string_literal: true

module PageViewsAnalyzer
  module Parse
    class PageViews
      def initialize(file_name)
        @file_name = file_name
        @path_with_visit_counts = {}
      end

      def call
        raise 'Input file does not found' unless input_file_present?

        read_and_parse_file
        path_with_visit_counts
      end

      private

      attr_reader :file_name
      attr_accessor :path_with_visit_counts

      def full_file_path
        @full_file_path ||= File.expand_path(file_name.to_s)
      end

      def input_file_present?
        File.exist?(full_file_path)
      end

      def file_object
        @file_object ||= File.open(full_file_path, 'r')
      end

      def read_and_parse_file
        file_object.each(&method(:parse_and_store_data))
      end

      def parse_and_store_data(line_string)
        path, ip = parsed_data(line_string)

        if path_with_visit_counts[path].nil?
          @path_with_visit_counts[path] = { ip => 1 }
        elsif path_with_visit_counts[path][ip].nil?
          @path_with_visit_counts[path][ip] = 1
        else
          @path_with_visit_counts[path][ip] += 1
        end
      end

      def parsed_data(line_string)
        PageViewsAnalyzer::Parse::PageView.new(line_string).call
      end
    end
  end
end
