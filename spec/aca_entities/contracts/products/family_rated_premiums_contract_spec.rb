# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Contracts::Products::FamilyRatedPremiumsContract do
  let(:family_rated_premiums) do
    {
      exchange_provided_code: 'R-ME002',
      primary_enrollee: 40.5,
      primary_enrollee_one_dependent: 80.5,
      primary_enrollee_two_dependents: 130.7,
      primary_enrollee_many_dependent: 159.0
    }
  end

  before do
    @result = subject.call(family_rated_premiums)
  end

  it 'should return success' do
    expect(@result.success?).to be_truthy
  end

  it 'should not have any errors' do
    expect(@result.errors.empty?).to be_truthy
  end
end
