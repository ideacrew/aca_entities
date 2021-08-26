# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Fdsh::Contracts::Person::PersonNameContract do
  context 'Calling contract with Valid params' do
    let(:given_name) { 'Michael' }
    let(:middle_name) { 'J' }
    let(:sur_name) { 'Brady' }

    let(:required_params) do
      { PersonGivenName: given_name, PersonSurName: sur_name }
    end
    let(:optional_params) { { PersonMiddleName: middle_name } }
    let(:all_params) { required_params.merge(optional_params) }

    context 'Calling the contract with required params' do
      it 'should pass vaidation' do
        result = described_class.new.call(required_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq required_params
      end
    end

    context 'Calling the contract with all params' do
      it 'should pass vaidation' do
        result = described_class.new.call(all_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq all_params
      end
    end
  end

  context 'Calling the contract with no params' do
    let(:error_message) do
      { PersonGivenName: ['is missing'], PersonSurName: ['is missing'] }
    end
    it 'should fail vaidation' do
      result = described_class.new.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end
end
