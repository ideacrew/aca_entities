# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/eligibilities/eligibilities_shared_context'

RSpec.describe AcaEntities::Eligibilities::Osse::Grant do
  include_context 'eligibilities_shared_context'
  subject { described_class }

  let(:value) do
    {
      title: 'Osse Premium Credit',
      key: 'OsseBenefitSponsorGrant'
    }
  end
  let(:required_params) do
    {
      title: 'Osse Eligibility',
      key: 'OsseBenefitSponsorGrant',
      value: value,
      start_on: five_days_from_today
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
        described_class.new(required_params.reject do |k, _v|
                              k == :value
                            end)
      end.to raise_error(Dry::Struct::Error, /:value is missing/)
    end
  end
end
