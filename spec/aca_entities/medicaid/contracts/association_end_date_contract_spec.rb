# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/association_end_date_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::AssociationEndDateContract, dbclean: :after_each do

  it 'should inherit from DateContract class' do
    expect(described_class).to be < ::AcaEntities::Medicaid::Contracts::DateContract
  end
end
