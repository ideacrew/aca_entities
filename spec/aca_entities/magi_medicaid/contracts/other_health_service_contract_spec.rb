# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Contracts::OtherHealthServiceContract, dbclean: :around_each do

  let(:all_params) do
    { has_received: true,
      is_eligible: false }
  end

  let(:invalid_params) do
    all_params.merge({ is_eligible: 'is_eligible' })
  end

  context 'with invalid params' do
    it 'should fail validation' do
      result = subject.call(invalid_params)
      expect(result).to be_failure
      expect(result.errors.to_h).to eq({ :is_eligible => ['must be boolean'] })
    end
  end

  context 'valid parameters' do
    it 'should pass validation' do
      result = subject.call(all_params)
      expect(result).to be_success
    end
  end
end
