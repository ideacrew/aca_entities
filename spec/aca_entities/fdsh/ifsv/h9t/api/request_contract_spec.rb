# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Fdsh::Ifsv::H9t::Contracts::Api::RequestContract do
  let(:request_id) { '154987' }

  let(:person_given_name) { 'Michael' }
  let(:person_middle_name) { 'J' }
  let(:person_sur_name) { 'Brady' }

  let(:identification_id) { '100101000' }
  let(:tax_filer_category_code) { 'PRIMARY' }

  let(:required_params) do
    {
      RequestID: request_id,
      IFSVApplicant: {
        Person: {
          PersonName: {
            PersonGivenName: person_given_name,
            PersonSurName: person_sur_name
          },
          PersonSSNIdentification: {
            IdentificationID: identification_id
          }
        },
        TaxFilerCategoryCode: tax_filer_category_code
      }
    }
  end

  let(:optional_params) do
    {
      IFSVApplicant: {
        Person: {
          PersonName: {
            PersonMiddleName: person_middle_name
          }
        }
      }
    }
  end

  let(:all_params) { required_params.deep_merge(optional_params) }

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
      { IFSVApplicant: ['is missing'], RequestID: ['is missing'] }
    end
    it 'should fail validation' do
      result = described_class.new.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end

  context 'RequestID ' do
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
  end

  context 'Attested tax filer who is not a tax dependent and SSN is missing' do
    it 'should fail validation'
  end

  context 'Duplicate SSNs within same request for different individuals' do
    it 'should fail validation'
  end
end
