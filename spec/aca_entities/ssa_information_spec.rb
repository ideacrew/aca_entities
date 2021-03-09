# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/ssa_information'

RSpec.describe ::AcaEntities::SsaInformation do

  describe 'with valid arguments' do
    let(:input_params) do
      { is_person_alive: true,
        is_person_incarcerated: true,
        prisoner_confinement_date: Date.today,
        prison_name: 'Prison',
        prison_address: 'Same Location' }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end
end
