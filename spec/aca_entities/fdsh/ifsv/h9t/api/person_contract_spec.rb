# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Fdsh::Ifsv::H9t::Contracts::Api::PersonContract do
  let(:person_given_name_0) { 'Michael' }
  let(:person_middle_name_0) { 'J' }
  let(:person_sur_name_0) { 'Brady' }
  let(:identification_id_0) { '100101000' }

  let(:person_name) do
    AcaEntities::Fdsh::Person::PersonName.new(
      PersonGivenName: person_given_name_0,
      PersonMiddleName: person_middle_name_0,
      PersonSurName: person_sur_name_0
    )
  end

  let(:person_ssn_identification) do
    AcaEntities::Fdsh::Person::PersonSSNIdentification.new(
      IdentificationID: identification_id_0
    )
  end

  let(:required_params) do
    {
      PersonName: person_name.to_h,
      PersonSSNIdentification: person_ssn_identification.to_h
    }
  end

  context 'Calling the contract with required params' do
    it 'should pass validation' do
      result = described_class.new.call(required_params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq required_params
    end
  end

  context 'Calling the contract with no params' do
    let(:error_message) do
      { PersonName: ['is missing'], PersonSSNIdentification: ['is missing'] }
    end
    it 'should fail validation' do
      result = described_class.new.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end
end
