# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Fdsh::Ifsv::H9t::Contracts::Api::IFSVApplicantContract do
  let(:person_name) { attributes_for(:fdsh_person_name) }
  let(:identification_id) { '100101000' }
  let(:tax_filer_category_code) { 'PRIMARY' }

  let(:person) do
    {
      PersonName: person_name,
      PersonSSNIdentification: {
        IdentificationID: identification_id
      }
    }
  end

  let(:required_params) do
    { Person: person, TaxFilerCategoryCode: tax_filer_category_code }
  end

  context 'Calling the contract with required params' do
    it 'should pass validation' do
      result = described_class.new.call(required_params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq required_params
    end
  end

  context 'Calling the contract with no params' do
    let(:error_message) do
      { Person: ['is missing'], TaxFilerCategoryCode: ['is missing'] }
    end
    it 'should fail validation' do
      result = described_class.new.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end
  context 'TaxFilerCategoyCode' do
    context 'TaxFilerCategoryCode is not an enumerated value' do
      let(:invalid_tax_filer_category_code) { 'COUSIN' }
      let(:tax_filer_category_code_error) do
        ['must be one of: PRIMARY, SPOUSE, DEPENDENT']
      end
      let(:invalid_ifsv_applicant) do
        required_params.merge(
          TaxFilerCategoryCode: invalid_tax_filer_category_code
        )
      end
      it 'should fail validation' do
        expect(
          described_class.new.call(invalid_ifsv_applicant).errors[
            :TaxFilerCategoryCode
          ]
        ).to eq tax_filer_category_code_error
      end
    end
  end
end
