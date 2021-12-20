# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/eligibilities/eligibilities_shared_context'

RSpec.describe AcaEntities::Eligibilities::Contracts::EligibilityStatesContract do
  include_context 'eligibilities_shared_context'
  subject { described_class.new }

  let(:eligibility_state) { { aptc_csr_eligibility: {} } }
  let(:eligibility_states) { { eligibility_states: eligibility_state } }

  context 'Given a eligibility_states key' do
    it 'should validate' do
      expect(subject.call(eligibility_states)).to be_truthy
    end
  end
end
