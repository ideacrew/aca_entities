# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Eligibilities::BenefitSponsorSubject do
  subject { described_class }

  let(:required_params) do
    {
      fein: '4232323',
      legal_name: 'Ideacrew',
      benefit_sponsorship_id: "122fwewe3456789"
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
                              k == :fein
                            end)
      end.to raise_error(Dry::Struct::Error, /:fein is missing/)
    end
  end
end
