# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/eligibilities/eligibilities_shared_context'

RSpec.describe AcaEntities::Eligibilities::Contracts::DeterminationsContract do
  include_context 'eligibilities_shared_context'
  subject { described_class.new }

  let(:determination) { { aptc_csr_eligibility: {} } }
  let(:determinations) { { determinations: determination } }

  context 'Given a determinations key' do
    it 'should validate' do
      expect(subject.call(determinations)).to be_truthy
    end
  end
end
