# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/mitc/transforms/eligibility_response'

RSpec.describe ::AcaEntities::MagiMedicaid::Mitc::Transforms::EligibilityResponse do
  describe 'When a valid json file passed' do

    let(:source_file) {Pathname.pwd.join("spec/support/magi_medicaid/mitc/eligibility_response.json")}

    it 'should parse and then transform when transform_mode set to batch' do
      AcaEntities::MagiMedicaid::Mitc::Transforms::EligibilityResponse.call(source_file, {transform_mode: :batch}) do |payload|
        binding.pry
        record = AcaEntities::MagiMedicaid::Mitc::Transforms::EligibilityResponse.transform(payload)
        binding.pry
        expect(record).to have_key(:determination_date)
        expect(record).to have_key(:person_id)
        expect(record).to have_key(:indicator)
      end
    end

    it 'should transform the payload according to instructions' do
      AcaEntities::Medicaid::Transforms::McrTo::CvInput.call(source_file) do |record|

        record[:applicants].tap do |applicant|
          expect(applicant).to have_key(:person_id)
          expect(applicant).to have_key(:medicaid_eligible)
        end
      end
    end
  end
end