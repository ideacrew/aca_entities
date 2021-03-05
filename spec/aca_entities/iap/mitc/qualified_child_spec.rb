# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/iap/mitc/types'
require 'aca_entities/iap/mitc/category_determination'
require 'aca_entities/iap/mitc/deprived_child'
require 'aca_entities/iap/mitc/relationship'
require 'aca_entities/iap/mitc/qualified_child'

RSpec.describe ::AcaEntities::Iap::Mitc::QualifiedChild do
  describe 'with valid arguments' do
    let(:input_params) do
      { person_id: 100,
        determination: { indicator_code: 'N',
                         ineligibility_code: 100,
                         ineligibility_reason: 'Nothing' },
        deprived_child: { qualify_as_deprived_child: 'N' },
        relationship: { other_id: 101,
                        attest_primary_responsibility: 'Y',
                        relationship_code: '01' } }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a ::AcaEntities::Iap::Mitc::QualifiedChild
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { subject }.to raise_error(Dry::Struct::Error)
    end
  end
end
