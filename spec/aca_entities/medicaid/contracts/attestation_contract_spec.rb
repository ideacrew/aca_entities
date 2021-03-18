# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/attestation_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::AttestationContract, dbclean: :after_each do

  let(:input_params) do
    { is_incarcerated: false,
      attested_not_incarcerated_indicator: false,
      attested_if_information_changes_indicator: true,
      attested_non_perjury_indicator: true,
      tax_return_access_indicator: true,
      tax_return_access: true }
  end

  context 'with all parameters' do
    it 'should pass validation' do
      result = subject.call(input_params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq input_params
    end
  end
end
