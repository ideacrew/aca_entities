# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Eligibilities::Types do
  subject { described_class.new }

  context 'EvidenceStateKind' do
    let(:valid_state_values) { %w[pending requested eligibility_review_required determined expired rejected errored] }
    let(:invalid_state_values) { %w[bogus_state red_alert] }

    it 'valid evidence states should validate' do
      valid_state_values.each { |state| expect(AcaEntities::Eligibilities::Types::EvidenceStateKind.valid?(state)).to be_truthy }
    end

    it 'invalid evidence states should fail validation' do
      invalid_state_values.each { |state| expect(AcaEntities::Eligibilities::Types::EvidenceStateKind.valid?(state)).to be_falsey }
    end
  end
end