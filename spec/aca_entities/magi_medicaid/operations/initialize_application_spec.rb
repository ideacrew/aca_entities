# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'
require 'aca_entities/magi_medicaid/shared_contexts/magi_medicaid_application_data'

RSpec.describe ::AcaEntities::MagiMedicaid::Operations::InitializeApplication do
  include_context 'setup magi_medicaid application with two applicants'

  context 'valid params' do
    before do
      @result = subject.call(iap_application)
    end

    it 'should return success' do
      expect(@result).to be_success
    end

    it 'should return entity object' do
      expect(@result.success).to be_a(::AcaEntities::MagiMedicaid::Application)
    end
  end

  context 'invalid params' do
    before do
      invalid_application = iap_application.merge({ applicants: [] })
      @result = subject.call(invalid_application)
    end

    it 'should return failure' do
      expect(@result).to be_failure
    end

    it 'should return failure with error messages' do
      expect(@result.failure.errors.to_h).to eq({ applicants: ['at least one applicant must be present'] })
    end
  end
end
