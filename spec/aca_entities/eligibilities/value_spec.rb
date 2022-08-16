# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/eligibilities/eligibilities_shared_context'

RSpec.describe AcaEntities::Eligibilities::Value do
  include_context 'eligibilities_shared_context'
  subject { described_class }

  let(:required_params) do
    {
      title: 'Osse Premium Credit',
      key: 'OsseBenefitSponsorGrant'
    }
  end

  context 'Initializing with required params' do
    it 'should initialize the entity' do
      result = described_class.new(required_params)

      expect(result).to be_a described_class
    end
  end

  context 'with invalid arguments' do
    it 'should raise error' do
      expect do
        described_class.new({title: 'Osse Premium Credit'})
      end.to raise_error(Dry::Struct::Error, /:key is missing/)
    end
  end
end
