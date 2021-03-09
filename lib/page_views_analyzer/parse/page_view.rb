# frozen_string_literal: true

# class to parse path and ip from line from log file
module PageViewsAnalyzer
  module Parse
    class PageView
      def initialize(line_string)
        @line_string = line_string
      end

      def call
        parse_and_assign_data

        [page_path, ip]
      end

      private

      attr_reader :line_string
      attr_accessor :page_path, :ip

      def parse_and_assign_data
        @page_path = parse_data[0]
        @ip = parse_data[1]
      end

      def parse_data
        @parse_data ||= line_string.split.map(&:strip)
      end
    end
  end
end
