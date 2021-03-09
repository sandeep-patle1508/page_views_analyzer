# frozen_string_literal: true

module PageViewsAnalyzer
  module Display
    class MostUniquelyVisitedPages < Base
      private

      def format_print_message(path_count_array)
        "#{path_count_array[0]} #{path_count_array[1]} unique views"
      end
    end
  end
end
