# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/applicant_role'
require 'aca_entities/vlp_document'
require 'aca_entities/iap/applicant'

RSpec.describe ::Iap::Applicant, dbclean: :after_each do
  let(:required_params) do
    { first_name: 'ivl40', last_name: '41',
      dob: Date.today.prev_year, gender: 'male',
      is_incarcerated: false, citizen_status: 'us_citizen',
      indian_tribe_member: true }
  end

  let(:optional_params) do
    { name_pfx: 'Mr.', middle_name: 'test', name_sfx: 'Jr.',
      ssn: '345343243', is_veteran_or_active_military: false,
      is_resident_post_092296: false, is_physically_disabled: false,
      is_self_attested_long_term_care: false, is_former_foster_care: false,
      addresses: [kind: 'home', address_1: '123', address_2: '', address_3: '',
                  city: 'was', county: '', state: 'DC', zip: '12321', country_name: ''],
      age_of_applicant: 25, person_hbx_id: '100', vlp_subject: 'I-327 (Reentry Permit)',
      expiration_date: Date.today.next_year, vlp_description: '', is_student: false,
      relationships: [], incomes: [], benefits: [], deductions: [], verifications: [] }
  end

  let(:all_params) { required_params.merge(optional_params) }

  context 'invalid params' do
    context 'with empty params' do
      it 'should raise error' do
        expect { subject }.to raise_error(Dry::Struct::Error, /:first_name is missing in Hash input/)
      end
    end
  end

  context 'valid params' do
    context 'required params only' do
      it { expect(described_class.new(required_params).to_h).to eq required_params }
    end

    context 'and required and optional params' do
      before { @result = described_class.new(all_params) }

      it 'should return all params' do
        expect(@result.to_h).to eq all_params
      end
    end
  end
end
