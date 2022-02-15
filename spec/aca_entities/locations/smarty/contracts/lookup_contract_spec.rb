# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Locations::Smarty::Contracts::LookupContract do
  subject { described_class.new }

  let(:input_id) { '12345' }
  let(:addressee) { 'IdeaCrew' }
  let(:street) { '1150 Connecticut Ave NW' }
  let(:street2) { '' }
  let(:secondary) { 'Suite 710' }
  let(:city) { 'Washington' }
  let(:state) { 'DC' }
  let(:zipcode) { '20036' }
  let(:lastline) { 'Washington DC 20036' }
  let(:urbanization) { '' }
  let(:candidates) { 3 }
  let(:match) { 'strict' }

  let(:required_params) { { street: street } }

  let(:optional_params) do
    {
      input_id: input_id,
      addressee: addressee,
      street2: street2,
      secondary: secondary,
      city: city,
      state: state,
      zipcode: zipcode,
      lastline: lastline,
      urbanization: urbanization,
      candidates: candidates,
      match: match
    }
  end

  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling contract with Valid params' do
    context 'Calling the contract with required params' do
      it 'should pass vaidation' do
        result = subject.call(required_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq required_params
      end
    end

    context 'Calling the contract with all params' do
      it 'should pass vaidation' do
        result = subject.call(all_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq all_params
      end
    end
  end

  context 'Calling the contract with no params' do
    let(:error_message) { { street: ['is missing'] } }
    it 'should fail vaidation' do
      result = subject.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end
end
