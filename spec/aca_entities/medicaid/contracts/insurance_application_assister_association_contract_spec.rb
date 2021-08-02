# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/insurance_application_assister_association_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::InsuranceApplicationAssisterAssociationnContract, dbclean: :after_each do

  let(:required_params) { {} }

  let(:optional_params) do
    { begin_date: { date: Date.today },
      end_date: { date: Date.today },
      assister_reference: { ref: "as123" } }
  end

  let(:all_params) { required_params.merge(optional_params)}

  context 'valid parameters' do
    context 'with optional parameters only' do

      before do
        @result = subject.call(optional_params)
      end

      it { expect(@result.success?).to be_truthy }
      it { expect(@result.to_h).to eq optional_params }
    end

    context 'with all required and optional parameters' do
      it 'should pass validation' do

        result = subject.call(all_params)

        expect(result.success?).to be_truthy
        expect(result.to_h).to eq all_params
      end
    end
  end
end
