# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Eligibilities::Contracts::BenefitSponsorSubjectContract do
  subject { described_class.new }

  let(:required_params) do
    {
      fein: '36232323',
      legal_name: 'Ideacrew',
      benefit_sponsorship_id: "12345678952eweqqw32",
    }
  end

  let(:all_params) { required_params }

  context 'contract with no params' do
    let(:error_message) do
      {
        fein: ['is missing'],
        legal_name: ['is missing'],
        benefit_sponsorship_id: ['is missing']
      }
    end

    it 'should fail validation' do
      result = described_class.new.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end

  context 'contract with required params' do

    it 'should pass validation' do
      result = subject.call(required_params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq required_params
    end
  end
end
