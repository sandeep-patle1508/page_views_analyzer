# frozen_string_literal: true

# class to parse path and ip from line from log file
module PageViewsAnalyzer
  module Parse
    class PageView
      IP_REGEX = /^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$/

      def initialize(line_string)
        @line_string = line_string
      end

      def call
        parse_and_assign_data
        validate_data

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

      def validate_data
        raise_validation_error("path can not be blank") if blank?(page_path)

        raise_validation_error('ip can not be blank') if blank?(ip)

        raise_validation_error("#{page_path} path must start with '/'") if invalid_path?

        raise_validation_error("#{ip} ip format is invalid") if invalid_ip?
      end

      def raise_validation_error(message)
        raise PageViewsAnalyzer::Exceptions::ValidationError, message
      end

      def blank?(value)
        value.nil? || value == ''
      end

      def invalid_path?
        !page_path.start_with?('/')
      end

      def invalid_ip?
        (ip =~ IP_REGEX).nil?
      end
    end
  end
end
