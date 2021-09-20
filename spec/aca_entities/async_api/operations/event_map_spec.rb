# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::AsyncApi::Operations::EventMap do
  subject { described_class.new }

  context 'when the operation is called' do
    it 'should produce an event hash' do
      result = subject.call

      expect(result.success?).to be_truthy
    end
  end
end
