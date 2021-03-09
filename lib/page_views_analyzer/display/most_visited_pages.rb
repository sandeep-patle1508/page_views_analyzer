# frozen_string_literal: true

module PageViewsAnalyzer
  module Display
    class MostVisitedPages < Base
      private

      def format_print_message(path_count_array)
        "#{path_count_array[0]} #{path_count_array[1]} visits"
      end
    end
  end
end
