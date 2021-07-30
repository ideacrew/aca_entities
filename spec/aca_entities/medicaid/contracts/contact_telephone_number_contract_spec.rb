# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/contact_telephone_number_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::ContactTelephoneNumberContract, dbclean: :after_each do

  let(:required_params) { {} }

  let(:optional_params) do
    {
      telephone:
      { telephone_number_full_id: "1231231234",
        telephone_suffix_id: "0" }
    }
  end

  let(:all_params) { required_params.merge(optional_params)}

  context 'invalid parameters' do
    context 'with unexpected parameters' do

      let(:input_params) { { cat: "meow" } }

      it { expect(subject.call(input_params)[:result]).to eq(nil) }
    end
  end

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
