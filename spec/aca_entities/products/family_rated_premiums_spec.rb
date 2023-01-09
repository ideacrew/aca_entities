# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Products::FamilyRatedPremiums, dbclean: :after_each do

  let(:family_rated_premiums) do
    {
      exchange_provided_code: 'R-ME002',
      primary_enrollee: 40.5,
      primary_enrollee_one_dependent: 80.5,
      primary_enrollee_many_dependent: 159.0
    }
  end

  before do
    params = AcaEntities::Contracts::Products::FamilyRatedPremiumsContract.new.call(family_rated_premiums).to_h
    @result = described_class.new(params)
  end

  it 'should return income entity object' do
    expect(@result).to be_a(described_class)
  end

  it 'should return all keys of income' do
    expect(@result.to_h.keys).to eq(family_rated_premiums.keys)
  end
end
