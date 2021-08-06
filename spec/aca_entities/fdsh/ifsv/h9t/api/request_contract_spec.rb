# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Fdsh::Ifsv::H9t::Contracts::Api::RequestContract do
  let(:request_id) { '154987' }
  let(:person_name_0) { attributes_for(:fdsh_person_name) }
  let(:identification_id_0) { '100101000' }
  let(:tax_filer_category_code_0) { 'PRIMARY' }

  let(:person_0) do
    {
      PersonName: person_name_0,
      PersonSSNIdentification: {
        IdentificationID: identification_id_0
      }
    }
  end

  let(:ifsv_applicant_0) do
    AcaEntities::Fdsh::Ifsv::H9t::Api::IFSVApplicant.new(
      { Person: person_0, TaxFilerCategoryCode: tax_filer_category_code_0 }
    )
  end

  let(:required_params) do
    { RequestID: request_id, IFSVApplicants: [ifsv_applicant_0.to_h] }
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
    let(:person_name_1) do
      attributes_for(:fdsh_person_name, PersonGivenName: 'Carol')
    end
    let(:identification_id_1) { '100101001' }
    let(:tax_filer_category_code_1) { 'SPOUSE' }

    let(:person_1) do
      {
        PersonName: person_name_1,
        PersonSSNIdentification: {
          IdentificationID: identification_id_1
        }
      }
    end

    let(:ifsv_applicant_1) do
      AcaEntities::Fdsh::Ifsv::H9t::Api::IFSVApplicant.new(
        Person: person_1,
        TaxFilerCategoryCode: tax_filer_category_code_1
      )
    end

    let(:multiple_applicants) do
      {
        RequestID: request_id,
        IFSVApplicants: [ifsv_applicant_0.to_h, ifsv_applicant_1.to_h]
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
end
