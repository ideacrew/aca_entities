# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/referral_activity_status'

RSpec.describe ::AcaEntities::Medicaid::Atp::ReferralActivityStatus,  dbclean: :around_each do
  
  describe 'with valid arguments' do
    let(:required_params) do
      { status_code: "Initiated" }
    end

    let(:optional_params) do
      { 
        overall_verification_status_code: "overall-code",
      }    
    end

    let(:all_params) { required_params.merge(optional_params)}

    it 'should initialize' do
      expect(described_class.new(all_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(all_params) }.not_to raise_error
    end
  end
end