# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/basis_for_outcome'

RSpec.describe ::AcaEntities::BasisForOutcome, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:required_params) { {} }

    let(:optional_params) do
      { is_blind_or_disabled: true,
        attested_long_term_care: false }
    end

    let(:all_params) { required_params.merge(optional_params)}

    it 'should initialize' do
      expect(described_class.new(all_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(all_params) }.not_to raise_error
    end
  end
end
