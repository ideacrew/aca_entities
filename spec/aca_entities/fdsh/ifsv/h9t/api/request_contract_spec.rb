# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Fdsh::Ifsv::H9t::Contracts::Api::RequestContract do
  let(:request_id) { '154987' }

  let(:person_given_name_0) { 'Michael' }
  let(:person_middle_name_0) { 'J' }
  let(:person_sur_name_0) { 'Brady' }
  let(:identification_id_0) { '100101000' }
  let(:tax_filer_category_code_0) { 'PRIMARY' }

  let(:person_0) do
    {
      PersonName: {
        PersonGivenName: person_given_name_0,
        PersonMiddleName: person_middle_name_0,
        PersonSurName: person_sur_name_0
      },
      PersonSSNIdentification: {
        IdentificationID: identification_id_0
      }
    }
  end

  let(:ifsv_applicant_0) do
    { Person: person_0, TaxFilerCategoryCode: tax_filer_category_code_0 }
  end

  let(:required_params) do
    { RequestID: request_id, IFSVApplicants: [ifsv_applicant_0] }
  end

  let(:all_params) { required_params }

  context 'Calling the contract with required params' do
    it 'should pass validation' do
      result = described_class.new.call(required_params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq required_params
    end
  end

  context 'Calling the contract with all params' do
    it 'should pass validation' do
      result = described_class.new.call(all_params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq all_params
    end
  end

  context 'Calling the contract with no params' do
    let(:error_message) do
      { IFSVApplicants: ['is missing'], RequestID: ['is missing'] }
    end
    it 'should fail validation' do
      result = described_class.new.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end

  context 'Calling the contract with multiple IFSVApplicatnts' do
    let(:person_given_name_1) { 'Carol' }
    let(:person_sur_name_1) { 'Brady' }
    let(:identification_id_1) { '100101000' }
    let(:tax_filer_category_code_1) { 'SPOUSE' }

    let(:person_1) do
      {
        PersonName: {
          PersonGivenName: person_given_name_1,
          PersonSurName: person_sur_name_1
        },
        PersonSSNIdentification: {
          IdentificationID: identification_id_1
        }
      }
    end

    let(:ifsv_applicant_1) do
      { Person: person_1, TaxFilerCategoryCode: tax_filer_category_code_1 }
    end

    let(:multiple_applicants) do
      {
        RequestID: request_id,
        IFSVApplicants: [ifsv_applicant_0, ifsv_applicant_1]
      }
    end

    it 'should pass validation' do
      result = described_class.new.call(multiple_applicants)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq multiple_applicants
    end
  end

  context 'RequestID ' do
    context 'value is compliant with 1-9 numeric chars only ' do
      it 'should pass validation' do
        expect(
          described_class.new.call({ RequestID: '000000001' }).errors[
            :RequestID
          ]
        ).to be_nil
        expect(
          described_class.new.call({ RequestID: '01' }).errors[:RequestID]
        ).to be_nil
        expect(
          described_class.new.call({ RequestID: '1' }).errors[:RequestID]
        ).to be_nil
        expect(
          described_class.new.call({ RequestID: '999999999' }).errors[
            :RequestID
          ]
        ).to be_nil
      end
    end

    context "value isn't compliant with 1-9 numeric chars only " do
      let(:request_id_error) { ['is in invalid format'] }
      it 'should fail validation' do
        expect(
          described_class.new.call({ RequestID: '0000000001' }).errors[
            :RequestID
          ]
        ).to eq request_id_error
        expect(
          described_class.new.call({ RequestID: '000000000123' }).errors[
            :RequestID
          ]
        ).to eq request_id_error
        expect(
          described_class.new.call({ RequestID: '1000000000' }).errors[
            :RequestID
          ]
        ).to eq request_id_error
      end
    end
  end

  context 'TaxFilerCategoyCode' do
    let(:valid_tax_filer_category_code) { 'SPOUSE' }

    context 'TaxFilerCategoryCode is an enumerated value' do
      let(:valid_ifsv_applicant) do
        {
          Person: person_0,
          TaxFilerCategoryCode: valid_tax_filer_category_code
        }
      end

      let(:valid_params) do
        { RequestID: request_id, IFSVApplicants: [valid_ifsv_applicant] }
      end

      it 'should pass validation' do
        expect(described_class.new.call(valid_params).success?).to be_truthy
      end
    end

    context 'TaxFilerCategoryCode is not an enumerated value' do
      let(:invalid_tax_filer_category_code) { 'COUSIN' }
      let(:tax_filer_category_code_error) do
        { TaxFilerCategoryCode: ['must be one of: PRIMARY, SPOUSE, DEPENDENT'] }
      end
      let(:invalid_ifsv_applicant) do
        {
          Person: person_0,
          TaxFilerCategoryCode: invalid_tax_filer_category_code
        }
      end

      let(:invalid_params) do
        { RequestID: request_id, IFSVApplicants: [invalid_ifsv_applicant] }
      end
      it 'should fail validation' do
        expect(
          described_class.new.call(invalid_params).errors[:IFSVApplicants].first
            .last
        ).to eq tax_filer_category_code_error
      end
    end
  end
end
