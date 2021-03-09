# frozen_string_literal: true

module PageViewsAnalyzer
  module Display
    class Base
      def initialize(visit_count_records)
        @visit_count_records = visit_count_records
      end

      def call
        visit_count_records.each(&method(:print_count_result))
      end

      private

      attr_reader :visit_count_records

      def print_count_result(path_count_array)
        puts format_print_message(path_count_array)
      end
    end
  end
end
