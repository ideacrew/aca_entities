# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/operations/transform_examples/mcr_to/cv_input'
require 'benchmark'

RSpec.describe ::AcaEntities::Operations::TransformExamples::McrTo::CvInput do
  describe 'When a valid json file passed' do

    let(:source_file) { Pathname.pwd.join("spec/support/transform_example_payloads/application.json") }

    it 'should parse and then transform when transform_mode set to batch' do
      AcaEntities::Operations::TransformExamples::McrTo::CvInput.call(source_file, { transform_mode: :batch }) do |payload|
        record = AcaEntities::Operations::TransformExamples::McrTo::CvInput.transform(payload)
        record_with_string_keys = JSON.parse(record.to_json)
        example_output_hash = JSON.parse(File.read(Pathname.pwd.join("spec/support/transform_example_payloads/family_transform_result.txt")))

        expect(record_with_string_keys).to match(example_output_hash)

        record[:family].tap do |family|
          expect(family).to have_key(:hbx_id)
          expect(family).to have_key(:broker_accounts)
          expect(family[:family_members].one? { |fm| fm[:is_primary_applicant] == true }).to be_truthy

          family[:family_members].each do |family_member|
            expect(family_member).to have_key(:is_primary_applicant)
            family_member[:person].tap do |person|
              expect(person).to have_key(:identifiers)
              expect(person[:identifiers]).to have_key(:source_system_key)
              person[:person_name].tap do |person_name|
                expect(person_name).to have_key(:full_name)
                expect(person_name[:full_name]).to eq("#{person_name[:first_name]} #{person_name[:last_name]}")
              end

              person[:addresses].each do |address|
                expect(address).to have_key(:kind)
                expect(address).to have_key(:address_1)
                expect(address).to have_key(:city)
                expect(address).to have_key(:state)
              end
            end
          end
        end
      end
    end

    it 'should transform the payload according to instructions' do
      AcaEntities::Operations::TransformExamples::McrTo::CvInput.call(source_file) do |record|
        record[:family].tap do |family|
          expect(record[:family]).to have_key(:hbx_id)
          expect(family).to have_key(:special_enrollment_periods)
          expect(family).to have_key(:irs_groups)
          expect(family).to have_key(:broker_accounts)
          expect(family).to have_key(:general_agency_accounts)
          expect(family).to have_key(:payment_transactions)
          expect(family).to have_key(:magi_medicaid_applications)

          expect(family[:family_members].one? { |fm| fm[:is_primary_applicant] == true }).to be_truthy

          family[:family_members].each do |family_member|
            expect(family_member).to have_key(:is_primary_applicant)
            family_member[:person].tap do |person|
              expect(person).to have_key(:identifiers)
              # expect(person).to have_key(:no_ssn)
              # expect(person).to have_key(:ethnicity)
              # expect(person).to have_key(:race)
              # expect(person).to have_key(:tribal_id)
              # expect(person).to have_key(:age)
              # expect(person).to have_key(:names)
              # expect(person).to have_key(:gender)
              # expect(person).to have_key(:is_homeless)
              # expect(person).to have_key(:is_temporarily_out_of_state)
              # expect(person).to have_key(:americanIndianAlaskanNativeIndicator)
              person[:person_name].tap do |person_name|
                expect(person_name).to have_key(:full_name)
                expect(person_name[:full_name]).to eq("#{person_name[:first_name]} #{person_name[:last_name]}")
              end
              expect(person).to have_key(:addresses)
              expect(person[:addresses]).to be_a(Array)
              person[:addresses].each do |address|
                expect(address).to have_key(:kind)
                expect(address).to have_key(:address_1)
                expect(address).to have_key(:city)
                expect(address).to have_key(:state)
                expect(address).to have_key(:zip)
                # expect(address).to have_key(:country_name)
                expect(address).to have_key(:county)
                expect(address).to have_key(:county_code)
              end
            end
          end
        end
      end
    end
  end
end
