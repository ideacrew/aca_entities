# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/contracts/attestation_contract'

RSpec.describe ::AcaEntities::Contracts::AttestationContract, dbclean: :after_each do

  let(:input_params) do
    { is_incarcerated: false }
  end

  context 'with all parameters' do
    it 'should pass validation' do
      result = subject.call(input_params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq input_params
    end
  end
end
