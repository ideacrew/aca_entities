# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/mitc_library'
require 'aca_entities/magi_medicaid/shared_contexts/magi_medicaid_application_data'

RSpec.describe AcaEntities::MagiMedicaid::Mitc::Transformers::ToMitc::EligibilityResponse do
  include_context 'setup magi_medicaid application with two applicants'

  before do
    described_class.call(mitc_response.to_json) { |record| @transform_result = record }
  end

  context 'return a hash with all the required transforms' do
    it 'should not return any errors when validated against the MitcEligibilityResponseContract' do
      expect(::AcaEntities::MagiMedicaid::Mitc::Contracts::EligibilityResponseContract.new.call(@transform_result).errors.to_h).to be_empty
    end

    it 'should transform all the eligibility response level attributes' do
      expect(@transform_result).to have_key(:determination_date)
      expect(@transform_result[:determination_date]).to eq(mitc_response[:'Determination Date'])
      expect(@transform_result[:applicants].count).to eq(2)
    end

    it 'should transform all the Applicant level attributes' do
      applicant1 = mitc_response[:Applicants].first
      @transform_result[:applicants].each do |applicant|
        expect(applicant).to be_a(Hash)
        expect(applicant).to have_key(:person_id)
        person_ids = mitc_response[:Applicants].collect { |app| app[:"Person ID"] }
        expect(person_ids).to include(applicant[:person_id])
        expect(applicant).to have_key(:person_id)

        medicaid_household = applicant[:medicaid_household]
        expect(medicaid_household[:people]).to eq(applicant1[:"Medicaid Household"][:People])
        expect(medicaid_household).to have_key(:magi_income)
        expect(medicaid_household).to have_key(:magi_as_percentage_of_fpl)
        expect(medicaid_household).to have_key(:size)

        expect(applicant[:is_medicaid_eligible]).to eq(applicant1[:'Medicaid Eligible'])
        expect(applicant[:is_chip_eligible]).to eq(applicant1[:'CHIP Eligible'])
        expect(applicant[:medicaid_ineligibility_reasons]).to eq(applicant1[:'Ineligibility Reason'])
        expect(applicant[:is_eligible_for_non_magi_reasons]).to eq(applicant1[:'Non-MAGI Referral'])
        expect(applicant[:chip_ineligibility_reasons]).to eq(applicant1[:'CHIP Ineligibility Reason'])
        expect(applicant[:medicaid_category]).to eq(applicant1[:Category])
        expect(applicant[:medicaid_category_threshold]).to eq(applicant1[:"Category Threshold"])
        expect(applicant[:chip_category]).to eq(applicant1[:"CHIP Category"])
        expect(applicant[:chip_category_threshold]).to eq(applicant1[:"CHIP Category Threshold"])

        expect(applicant).to have_key(:determinations)
        cat_det = ::AcaEntities::MagiMedicaid::Mitc::Contracts::CategoryDeterminationContract.new
        applicant[:determinations].each do |category_determination|
          expect(cat_det.call(category_determination).errors.to_h).to be_empty
        end

        expect(applicant).to have_key(:other_output)
        other_output = applicant[:other_output]
        expect(other_output).to have_key(:qualified_children_list)
      end
    end
  end
end
