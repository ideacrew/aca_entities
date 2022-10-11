# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Contracts::BenchmarkProducts::MemberContract,  dbclean: :after_each do
  subject { described_class.new.call(input_params) }

  describe '#call' do
    context 'with valid input_params' do
      let(:input_params) do
        { applicant_reference: { first_name: 'first_name',
                                 last_name: 'last_name',
                                 dob: Date.today,
                                 person_hbx_id: '109990' },
          relationship_with_primary: 'self',
          age_on_effective_date: 20 }
      end

      it 'should return success moand' do
        expect(subject).to be_success
      end
    end

    context 'with invalid input_params' do
      let(:input_params) { {} }

      it 'should return failure moand with error keys' do
        expect(subject).to be_failure
        expect(subject.errors.to_h.keys).to eq([:applicant_reference, :relationship_with_primary, :age_on_effective_date])
      end
    end
  end
end
