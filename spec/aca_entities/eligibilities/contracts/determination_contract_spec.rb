# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/eligibilities/eligibilities_shared_context'

RSpec.describe AcaEntities::Eligibilities::Contracts::DeterminationContract do
  include_context 'eligibilities_shared_context'
  subject { described_class.new }

  let(:subjects) { { subjects: {} } }

  context 'Given a subjects key' do
    it 'should validate' do
      expect(subject.call(subjects)).to be_truthy
    end
  end
end
