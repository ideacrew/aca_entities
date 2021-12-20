# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/eligibilities/eligibilities_shared_context'

RSpec.describe AcaEntities::Eligibilities::Determination do
  include_context 'eligibilities_shared_context'
  subject { described_class }

  let(:subjects) { { subjects: {} } }

  let(:required_params) { { subjects: subjects } }

  let(:all_params) { required_params }

  context 'Initializing with required params' do
    it 'should pass initialize' do
      result = described_class.new(required_params)

      expect(result).to be_a described_class
    end
  end
end
