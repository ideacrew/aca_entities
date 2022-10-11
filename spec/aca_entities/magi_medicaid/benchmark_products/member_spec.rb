# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::BenchmarkProducts::Member, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:member) do
      { applicant_reference: { first_name: 'first_name',
                               last_name: 'last_name',
                               dob: Date.today,
                               person_hbx_id: '109990' },
        relationship_with_primary: 'self',
        age_on_effective_date: 20 }
    end

    before do
      validated_params = AcaEntities::MagiMedicaid::Contracts::BenchmarkProducts::MemberContract.new.call(member)
      @result = if validated_params.failure?
                  validated_params
                else
                  described_class.new(validated_params.to_h)
                end
    end

    it 'should match all the input keys of member' do
      expect(@result.to_h.keys).to eq(member.keys)
    end

    it 'should match all the input keys of applicant_reference' do
      expect(@result.to_h[:applicant_reference].keys).to eq(member[:applicant_reference].keys)
    end
  end
end
