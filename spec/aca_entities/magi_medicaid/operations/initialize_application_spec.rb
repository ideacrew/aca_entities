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
    context 'empty applicant param' do
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

  context 'member_determinations param' do
    context 'set to nil' do
      before do
        invalid_application = iap_application
        ped = invalid_application[:tax_households].first[:tax_household_members].first[:product_eligibility_determination]
        ped = ped.merge({ member_determinations: nil })
        invalid_application[:tax_households].first[:tax_household_members].first[:product_eligibility_determination] = ped
        @result = subject.call(invalid_application)
      end

      it 'should return success' do
        expect(@result).to be_success
      end
    end

    context 'set to expected content' do
      let(:member_determinations) do
        [{ kind: 'Medicaid/CHIP Determination',
           criteria_met: true,
           determination_reasons: ['not_lawfully_present_pregnant'],
           eligibility_overrides: [{
             override_rule: 'not_lawfully_present_pregnant',
             override_applied: true
           }] }]
      end
      before do
        invalid_application = iap_application
        ped = invalid_application[:tax_households].first[:tax_household_members].first[:product_eligibility_determination]
        ped = ped.merge({ member_determinations: member_determinations })
        invalid_application[:tax_households].first[:tax_household_members].first[:product_eligibility_determination] = ped
        @result = subject.call(invalid_application)
      end

      it 'should return success' do
        expect(@result).to be_success
      end
    end
  end
end
