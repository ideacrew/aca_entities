# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/contracts/dhs_save_contract'

RSpec.describe AcaEntities::Contracts::DhsSaveContract, type: :model do

  it 'should be a container-ready operation' do
    expect(subject.respond_to?(:call)).to be_truthy
  end

  context 'success case' do
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

    before do
      @result = subject.call(input_params)
    end

    it 'should return success' do
      expect(@result.success?).to be_truthy
    end

    it 'should not have any errors' do
      expect(@result.errors.empty?).to be_truthy
    end
  end

  context 'invalid params' do
    let(:input_params) do
      {
        class_of_admission_code: 'Test',
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

    before do
      @result = subject.call(input_params)
    end

    it 'should return failure with errors' do
      expect(@result.errors.messages.first.text).to match(/must be one of: IR1, IR6/)
    end
  end
end
