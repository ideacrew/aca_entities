# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/contracts/applicant_reference_contract'

RSpec.describe ::AcaEntities::MagiMedicaid::Contracts::ApplicantReferenceContract,  dbclean: :after_each do

  subject do
    described_class.new.call(params)
  end

  describe 'passing empty values for fields' do
    let(:params) do
      { first_name: '',
        last_name: '',
        dob: '',
        person_hbx_id: '' }
    end

    let(:error_message) do
      { dob: ['must be filled'],
        first_name: ['must be filled'],
        last_name: ['must be filled'],
        person_hbx_id: ['must be filled'] }
    end

    it 'fails' do
      expect(subject.errors.to_h).to eq error_message
    end
  end

  describe 'passing valid fields' do
    let(:params) do
      { first_name: 'first',
        last_name: 'last',
        dob: Date.today.prev_year.to_s,
        person_hbx_id: '100' }
    end

    it 'passes' do
      expect(subject).to be_success
    end
  end
end
