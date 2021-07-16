# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/immigration_document_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::ImmigrationDocumentContract, dbclean: :after_each do

  let(:input_params) do
    { expiration_date: { date: Date.today.next_year },
      document_numbers: [{ identification_id: '123456789' }],
      document_person_ids: [{ identification_id: 'a-person-id' }],
      same_name_indicator: false,
      category_code: 'I327',
      category_text: 'test' }
  end

  context 'with all parameters' do
    it 'should pass validation' do
      result = subject.call(input_params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq input_params
    end
  end
end