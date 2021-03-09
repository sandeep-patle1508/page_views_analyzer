# frozen_string_literal: true

require_relative 'run_application'

raise 'Required input file argument is missing.' if ARGV.first.nil?

RunApplication.new(ARGV.first).call
