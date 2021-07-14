# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp'

RSpec.describe ::AcaEntities::Medicaid::Atp::AccountTransferRequest, dbclean: :after_each do

  let(:transfer_header_params) do
    {
      transfer_activity: { transfer_id: { identification_id: '2163565' },
                           transfer_date: { date_time: DateTime.now },
                           number_of_referrals: 1,
                           recipient_code: 'MedicaidCHIP',
                           state_code: 'ME' }
    }
  end

  let(:person_params) do
    [{
      id: 'a-person-id',
      person_name: { given: "first", sur: "last" },
      ssn_identification: { identification_id: '012345678' },
      sex: 'Sex'
    }]
    # { person_name: { first_name: 'ivl40', last_name: '41' },
    # demographic: { dob: Date.new(2000, 1, 1), gender: 'Male' },
    # citizenship_immigration_status_information: { us_citizen: true },
    # native_american_information: { is_native_american_or_alaska_native: false } }
  end

  let(:insurance_application_params) do
    {
      insurance_applicants: [{ role_reference: { ref: "a-person-id" }, fixed_address_indicator: true }],
      requesting_financial_assistance: false,
      requesting_medicaid: false,
      ssf_primary_contact: { role_reference: { ref: "a-person-id" }, contact_preference: "Email" },
      ssf_signer: ssf_signer,
      tax_return_access: false,
      application_creation: application_creation,
      application_submission: application_submission,
      application_identifications: [{ identification_id: "Exchange" }]
    }
  end

  let(:medicaid_household_params) do
    # [{
    #   household_income: { monthly_income_greater_than_fpl: true, income_type_code: 'CapitalGains',  income_amount: 500.00,
    #                       income_frequency: 'Weekly', income_from_tribal_source: 120.00, monthly_attested_medicaid_household_current_income: nil,
    #                       annual_total_project_medicaid_household_current_income: nil },
    #   household_composition: { medicaid_household_size: 3, qualified_children_list: 'Sansa, Stark' }
    # }]
  end

  let(:sender_params) {[{ id: "Sender", category_code: 'Exchange' }]}
  let(:receiver_params) {[{ id: "Receiver", category_code: 'Exchange' }]}

  let(:physical_household) do
    {
      household_size_quantity: 1,
      household_member_references: [{ ref: "a-person-id" }]
    }
  end

  let(:required_params) do
    {
      transfer_header: transfer_header_params, people: person_params, insurance_application: insurance_application_params,
      medicaid_households: medicaid_household_params, senders: sender_params, receivers: receiver_params, physical_households: []
    }
  end

  let(:ssf_signer) do
    {
      role_reference: { ref: "a-person-id" },
      signature: signature,
      ssf_attestation: ssf_attestation
    }
  end

  let(:ssf_attestation) do
    {
      non_perjury_indicator: true,
      not_incarcerated_indicators: [{ metadata: nil, value: true }],
      information_changes_indicator: false
    }
  end

  let(:signature) do
    {
      signature_date: { date: DateTime.now.to_date }
    }
  end

  let(:application_creation) do
    {
      creation_id: { identification_id: '2163565' },
      creation_date: { date_time: DateTime.now }
    }
  end

  let(:application_submission) do
    {
      activity_id: { identification_id: '2163565' },
      activity_date: { date_time: DateTime.now }
    }
  end

  context 'valid params' do
    context 'required params only' do
      it { expect(described_class.new(required_params).to_h).to eq required_params }
    end
  end
end
