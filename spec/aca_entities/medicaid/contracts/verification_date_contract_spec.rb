# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/verification_date_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::VerificationDateContract do

  it 'should inherit from DateContract class' do
    expect(described_class).to be < ::AcaEntities::Medicaid::Contracts::DateContract
  end
end
