# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/contracts/identifying_information_contract'

RSpec.describe ::AcaEntities::Contracts::IdentifyingInformationContract, dbclean: :after_each do

  let(:input_params) do
    { ssn: '123456789',
      hbx_id: '100' }
  end

  context 'valid parameters' do
    context 'with all parameters' do
      it 'should pass validation' do
        result = subject.call(input_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq input_params
      end
    end
  end
end
