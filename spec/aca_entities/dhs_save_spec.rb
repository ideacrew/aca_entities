# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/dhs_save'

RSpec.describe ::AcaEntities::DhsSave do

  describe 'with valid arguments' do
    let(:input_params) do
      {
        class_of_admission_code: 'IR1',
        admission_end_date: Date.today.next_year,
        save_step: '1',
        case_nbr: nil,
        eligibility_statement_code: nil,
        lawful_presence_verified_code: nil,
        five_year_bar_code: nil,
        qualified_non_citizen_code: nil,
        five_year_bar_met_code: nil,
        us_citizen_code: nil,
        grant_date: nil,
        g_845_major_cd: nil,
        dhs_comments: nil
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
