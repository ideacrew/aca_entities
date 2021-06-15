# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/application_metadata_contract'

RSpec.describe AcaEntities::Medicaid::Contracts::ApplicationMetadataContract, type: :model do

  it 'should be a container-ready operation' do
    expect(subject.respond_to?(:call)).to be_truthy
  end

  let(:input_params) do
    { application_ids: [{identification_id:  '12345'}], application_signature_date: DateTime.new,
      creation_date: DateTime.new, identification_category_text: 'state' }
  end

  context 'success case' do
    before do
      @result = subject.call(input_params)
    end

    it 'should return success' do
      expect(@result.success?).to be_truthy
    end

    it 'should not have any errors' do
      expect(@result.errors.empty?).to be_truthy
    end
  end
end
