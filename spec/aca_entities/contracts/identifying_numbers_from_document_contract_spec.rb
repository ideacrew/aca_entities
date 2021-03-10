# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/contracts/identifying_numbers_from_document_contract'

RSpec.describe ::AcaEntities::Contracts::IdentifyingNumbersFromDocumentContract, dbclean: :after_each do

  let(:input_params) do
    { identifying_number: '123456789',
      identifying_number_type: 'Certificate of Citizenship',
      foreign_passport_country_of_issuance_code: 'USA' }
  end

  context 'with all parameters' do
    it 'should pass validation' do
      result = subject.call(input_params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq input_params
    end
  end
end
