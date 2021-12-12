# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Eligibilities::Contracts::EvidenceStateContract do
  subject { described_class.new }

  let(:evidence_gid) { 'gid://enroll_app/FinancialAssistance::Application/676767/Applicant/55555' }
  let(:state) { 'determined' }
  let(:is_satisfied) { false }
  let(:verification_outstanding) { true }
  let(:due_on) { Date.today + 1 }
  let(:visited_at) { DateTime.now }

  let(:optional_params) { { evidence_gid: evidence_gid, visited_at: visited_at } }

  let(:required_params) { { state: state, is_satisfied: is_satisfied, verification_outstanding: verification_outstanding, due_on: due_on } }

  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling the contract with no params' do
    let(:error_message) { { state: ['is missing'], is_satisfied: ['is missing'], verification_outsnatanding: ['is _missing'], due_on: ['is missing'] } }
    it 'should fail validation' do
      result = described_class.new.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end

  context 'Calling the contract with required params' do
    it 'should pass validation' do
      result = described_class.new.call(required_params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq required_params
    end
  end

  context 'TaxFilerCategoyCode' do
    context 'TaxFilerCategoryCode is not an enumerated value' do
      let(:invalid_tax_filer_category_code) { 'COUSIN' }
      let(:tax_filer_category_code_error) { ['must be one of: PRIMARY, SPOUSE, DEPENDENT'] }
      let(:invalid_ifsv_applicant) { required_params.merge(TaxFilerCategoryCode: invalid_tax_filer_category_code) }
      it 'should fail validation' do
        expect(described_class.new.call(invalid_ifsv_applicant).errors[:TaxFilerCategoryCode]).to eq tax_filer_category_code_error
      end
    end
  end
end
