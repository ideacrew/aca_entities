# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/sender'
require 'aca_entities/medicaid/atp/receiver'
require 'aca_entities/medicaid/atp/referral_header'

RSpec.describe ::AcaEntities::Medicaid::Atp::ReferralHeader do

  describe 'with valid arguments' do
    let(:input_params) do
      {
        referral_id: nil,
        referral_date: nil,
        evidence_documents_available: nil,
        referral_activity_reason: nil,
        referral_activity_eligibility: nil,
        referral_activity_status: nil,
        referral_activity_over_all_verification_status: nil
      }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end

    context 'invalid input for referral_date' do
      let(:a) { described_class.new(input_params.merge(referral_date: Date.today.to_date)) }
      it 'should return error message' do
        expect { a }.to raise_error(Dry::Struct::Error, /has invalid type for :referral_date/)
      end
    end
  end
end
