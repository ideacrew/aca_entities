# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp'

RSpec.describe ::AcaEntities::Medicaid::Atp::AccountTransferRequest, dbclean: :after_each do
  let(:transfer_header_params) do
    {
      transfer_id: '1234567890',
      transfer_date: Date.today.to_datetime,
      number_of_referrals: 4,
      recipient_code: 'code',
      state_code: 'MA'
    }
  end
  let(:person_params) do
    { person_name: { first_name: 'ivl40', last_name: '41' },
      demographic: { dob: Date.new(2000, 1, 1), gender: 'Male' },
      citizenship_immigration_status_information: { us_citizen: true },
      native_american_information: { is_native_american_or_alaska_native: false } }
  end

  let(:insurance_application_params) do
    { application_metadata: { application_id: '12345', application_signature_date: DateTime.new,
                             creation_date: DateTime.new, identification_category_text: 'state' },
      attestation: { is_incarcerated: false, attested_not_incarcerated_indicator: false,
                     attested_if_information_changes_indicator: true, attested_non_perjury_indicator: true,
                     tax_return_access_indicator: true, tax_return_access: true } }
  end

  let(:medicaid_household_params) do
    {
      household_income: { monthly_income_greater_than_fpl: true, income_type_code: 'CapitalGains',  income_amount: 500.00,
                          income_frequency: 'Weekly', income_from_tribal_source: 120.00, monthly_attested_medicaid_household_current_income: nil,
                          annual_total_project_medicaid_household_current_income: nil },
      household_composition: { medicaid_household_size: 3, qualified_children_list: 'Sansa, Stark' }
    }
  end

  let(:sender_params) {{ sender_code: nil, sender_medicaid_chip_state: nil }}
  let(:receiver_params) {{ recipient_code: '12345' }}
  let(:physical_household) {{ household_size_quantity: 2, household_member_reference: [5_762_879, 762_839] }}
  let(:required_params) do
    {
      transfer_header: transfer_header_params, person: person_params, insurance_application: insurance_application_params,
      medicaid_household: medicaid_household_params, sender: sender_params, receiver: receiver_params, physical_household: physical_household
    }
  end
  context 'valid params' do
    context 'required params only' do
      it { expect(described_class.new(required_params).to_h).to eq required_params }
    end
  end
end
