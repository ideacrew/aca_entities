# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/navigator'

RSpec.describe ::AcaEntities::Medicaid::Atp::Navigator do

  describe 'with valid arguments' do
    let(:input_params) do
      {
        first_name: nil,
        middle_name: nil,
        last_name: 'Assister',
        suffix: nil,
        organization_name: nil,
        organization_id: nil,
        broker_user_id: nil,
        broker_npn: nil,
        designation_date: Date.today.to_date
      }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end
end
