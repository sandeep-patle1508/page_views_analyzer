# frozen_string_literal: true

# class to parse path and ip from line from log file
module PageViewsAnalyzer
  module Parse
    class ValidatePagePathAndIp
      IP_REGEX = /^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$/.freeze

      def initialize(page_path:, ip:)
        @page_path = page_path
        @ip = ip
      end

      def call
        raise_validation_error('path can not be blank') if page_path_blank?

        raise_validation_error('ip can not be blank') if ip_blank?

        raise_validation_error("#{page_path} path must start with '/'") if invalid_path?

        raise_validation_error("#{ip} ip format is invalid") if invalid_ip?
      end

      private

      attr_reader :page_path, :ip

      def raise_validation_error(message)
        raise PageViewsAnalyzer::Exceptions::ValidationError, message
      end

      def page_path_blank?
        blank?(page_path)
      end

      def ip_blank?
        blank?(ip)
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
