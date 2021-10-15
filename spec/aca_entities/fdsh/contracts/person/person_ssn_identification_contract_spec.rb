# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Fdsh::Contracts::Person::PersonSSNIdentificationContract do
  context 'Calling contract with required params' do
    let(:valid_ssn) { '518124854' }
    # let(:invalid_ssn) { '666998585' }

    context 'and the SSN value is valid' do
      let(:valid_params) { { IdentificationID: valid_ssn } }
      it 'should pass vaidation' do
        result = described_class.new.call(valid_params)
        expect(result.success?).to be_truthy
      end
    end

    # Not validating ssn Because we are storing or sending only enccrypted ssn's

    # context 'and the SSN value is invalid' do
    #   let(:invalid_params) { { IdentificationID: invalid_ssn } }
    #   let(:error_message) { { IdentificationID: ['is in invalid format'] } }

    #   it 'should fail vaidation' do
    #     result = described_class.new.call(invalid_params)
    #     expect(result.failure?).to be_truthy
    #     expect(result.errors.to_h).to eq error_message
    #   end
    # end
  end

  context 'Calling the contract with no params' do
    let(:error_message) { { IdentificationID: ['is missing'] } }

    it 'should fail vaidation' do
      result = described_class.new.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end
end
