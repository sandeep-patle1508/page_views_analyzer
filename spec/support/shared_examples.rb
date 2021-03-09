# frozen_string_literal: true

RSpec.shared_examples 'should raise validation error' do
  it 'raises validation error' do
    expect { subject.call }.
      to raise_error(PageViewsAnalyzer::Exceptions::ValidationError, error_message)
  end
end
