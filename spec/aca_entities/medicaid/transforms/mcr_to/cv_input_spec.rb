# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/transforms/mcr_to/cv_input'
require 'benchmark'

RSpec.describe ::AcaEntities::Medicaid::Transforms::McrTo::CvInput do
  describe 'When a valid json file passed' do

    let(:source_file) { Pathname.pwd.join('spec', 'support', 'application.json') }

    # it 'should transform the payload' do
    #   counter = 0
    #   puts Benchmark.measure {
    #     AcaEntities::Medicaid::Transforms::McrTo::CvInput.call(source_file, "test.json", {}) do |record|
    #       counter += 1
    #     end
    #   }
    #   # expect(result).to eql(output)
    # end

    it 'should transform the payload according to instructions' do
      AcaEntities::Medicaid::Transforms::McrTo::CvInput.call(source_file, "test.json", {}) do |record|

        record[:family].tap do |family|
          expect(family).to have_key(:hbx_id)
          expect(family).to have_key(:vlp_documents_status)
          expect(family).to have_key(:min_verifications_due_date)
          expect(family).to have_key(:special_enrollment_periods)
          expect(family).to have_key(:irs_groups)
          expect(family).to have_key(:broker_agency_accounts)
          expect(family).to have_key(:general_agency_accounts)
          expect(family).to have_key(:payment_transactions)
          expect(family).to have_key(:financial_assistance_applications)
          family[:family_members].each do |family_member|
            expect(family_member).to have_key(:is_primary_applicant)
            family_member[:person].tap do |person|
              expect(person).to have_key(:identifiers)
              expect(person).to have_key(:no_ssn)
              expect(person).to have_key(:ethnicity)
              expect(person).to have_key(:race)
              expect(person).to have_key(:tribal_id)
              expect(person).to have_key(:age)
              expect(person).to have_key(:names)
              expect(person).to have_key(:gender)
              expect(person).to have_key(:is_homeless)
              # expect(person).to have_key(:is_temporarily_out_of_state)
              # expect(person).to have_key(:americanIndianAlaskanNativeIndicator)
              expect(person).to have_key(:addresses)
            end
          end
        end
      end
    end
  end
end
