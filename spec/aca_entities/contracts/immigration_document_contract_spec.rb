# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/contracts/immigration_document_contract'

RSpec.describe ::AcaEntities::Contracts::ImmigrationDocumentContract, dbclean: :after_each do

  let(:input_params) do
    { expiration_date: Date.today.next_year,
      document_number: '123456789',
      document_type_code: 'I327',
      document_type_other_code: 'test' }
  end

  context 'with all parameters' do
    it 'should pass validation' do
      result = subject.call(input_params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq input_params
    end
  end
end
