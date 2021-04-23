# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/operations/transform_examples/to_mitc_contract/eligibility_response'

RSpec.describe ::AcaEntities::Operations::TransformExamples::ToMitcContract::EligibilityResponse do
  describe 'When a valid json file passed' do
    let(:source_file) {Pathname.pwd.join("spec/support/transform_example_payloads/eligibility_response.json")}

    it 'should parse and then transform when transform_mode set to batch' do
      AcaEntities::Operations::TransformExamples::ToMitcContract::EligibilityResponse.call(source_file, { transform_mode: :batch }) do |payload|
        record = AcaEntities::Operations::TransformExamples::ToMitcContract::EligibilityResponse.transform(payload)
        expect(record).to have_key(:determination_date)
        record[:applicants].each do |applicant|
          expect(applicant).to have_key(:person_id)
          applicant[:medicaid_household].tap do |medicaid_household|
            expect(medicaid_household[:people]).to be_a(Array)
            expect(medicaid_household).to have_key(:magi)
          end
          expect(applicant).to have_key(:medicaid_eligible)
          expect(applicant[:chip_ineligible_reason]).to be_a(Array)
          applicant[:determinations].each do |_key, value|
            value.tap do |ds|
              expect(ds).to have_key(:indicator)
            end
          end
          applicant[:cleandets].each do |cleandet|
            cleandet.tap do |cleandet_rec|
              expect(cleandet_rec).to have_key(:determination_kind)
              expect(cleandet_rec).to have_key(:status)
            end
          end
        end
      end
    end

    it 'should transform the payload according to instructions' do
      AcaEntities::Operations::TransformExamples::ToMitcContract::EligibilityResponse.call(source_file) do |record|
        expect(record).to have_key(:determination_date)
        record[:applicants].each do |applicant|
          expect(applicant).to have_key(:person_id)
          applicant[:medicaid_household].tap do |medicaid_household|
            expect(medicaid_household[:people]).to be_a(Array)
            expect(medicaid_household).to have_key(:magi)
          end
          expect(applicant).to have_key(:medicaid_eligible)
          expect(applicant[:chip_ineligible_reason]).to be_a(Array)
          applicant[:determinations].each do |_key, value|
            value.tap do |ds|
              expect(ds).to have_key(:indicator)
            end
          end
          applicant[:cleandets].each do |cleandet|
            cleandet.tap do |cleandet_rec|
              expect(cleandet_rec).to have_key(:determination_kind)
              expect(cleandet_rec).to have_key(:status)
            end
          end
        end
      end
    end
  end
end
