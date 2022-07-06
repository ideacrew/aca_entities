# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/ios/transformers/application'

RSpec.describe AcaEntities::Medicaid::Ios::Transformers::Application do

  describe 'When a valid cv3 application payload is passed' do
    # should use more recent example payload?
    let(:family) do
      File.read(Pathname.pwd.join("spec/support/atp/sample_payloads/uber_payload.json"))
    end

    # should just load in a sample json of data-prepped application
    let(:application) do
      family_hash = JSON.parse(family)
      application = family_hash['family']['magi_medicaid_applications']
      applicants = application['applicants']

      # simulate data prep (transforms can't handle arrays, need to prepare as hash)
      person_hbx_ids = applicants.map {|applicant| applicant['person_hbx_id']}
      applicants_hash = person_hbx_ids.each_with_object({}) do |id, hash|
        hash[id] = applicants.detect {|applicant| applicant['person_hbx_id'] == id}
      end
      application['applicants'] = applicants_hash
      primary_applicant = applicants.detect {|applicant| applicant['is_primary_applicant']}
      primary_first_name = primary_applicant['name']['first_name']
      primary_last_name = primary_applicant['name']['last_name']
      application['primary_applicant_name'] = "#{primary_first_name} #{primary_last_name}"

      JSON.generate(application)
    end

    before do
      described_class.call(application) { |record| @transform_result = record }
    end

    it 'should transform the payload according to instructions' do
      expect(@transform_result).to have_key(:Name)
    end
  end
end