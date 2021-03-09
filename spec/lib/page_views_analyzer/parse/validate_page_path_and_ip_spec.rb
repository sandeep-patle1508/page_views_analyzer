# frozen_string_literal: true

require './lib/page_views_analyzer'

describe PageViewsAnalyzer::Parse::ValidatePagePathAndIp do
  subject { described_class.new(page_path: page_path, ip: ip) }

  let(:page_path) { '/example_path' }
  let(:ip) { '111.222.333.444' }

  it 'does not raise validation error' do
    expect { subject.call }.not_to raise_error
  end

  context 'when input log data is invalid' do
    context 'when path is blank' do
      let(:page_path) { '' }
      let(:ip) { '111.222.333.444' }
      let(:error_message) { 'path can not be blank' }

      include_examples 'should raise validation error'
    end

    context 'when ip is blank' do
      let(:page_path) { '/example_path' }
      let(:ip) { '' }
      let(:error_message) { 'ip can not be blank' }

      include_examples 'should raise validation error'
    end

    context 'when path does not start with /' do
      let(:page_path) { 'example_path' }
      let(:ip) { '111.222.333.444' }
      let(:error_message) { "example_path path must start with '/'" }

      include_examples 'should raise validation error'
    end

    context 'when ip format is invalid' do
      let(:page_path) { '/example_path' }
      let(:ip) { '111.222.333.4445' }
      let(:error_message) { '111.222.333.4445 ip format is invalid' }

      include_examples 'should raise validation error'
    end
  end
end
