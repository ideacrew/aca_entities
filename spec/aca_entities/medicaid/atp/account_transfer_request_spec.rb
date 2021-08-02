# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp'

RSpec.describe ::AcaEntities::Medicaid::Atp::AccountTransferRequest, dbclean: :after_each do

  let(:required_params) do
    {
      transfer_header: transfer_header_params, people: person_params, insurance_application: insurance_application_params,
      senders: sender_params, receivers: receiver_params, physical_households: physical_household_params
    }
  end

  let(:optional_params) do
    {
      medicaid_households: medicaid_household_params,
      authorized_representative: {},
      tax_returns: tax_return_params
    }

  end

  let(:all_params) { required_params.merge(optional_params) }

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
    [{
      household_income: { monthly_income_greater_than_fpl: true, income_type_code: 'CapitalGains',  income_amount: 500.00,
                          income_frequency: 'Weekly', income_from_tribal_source: 120.00, monthly_attested_medicaid_household_current_income: nil,
                          annual_total_project_medicaid_household_current_income: nil },
      household_composition: { medicaid_household_size: 3, qualified_children_list: 'Sansa, Stark' }
    }]
  end

  let(:sender_params) {[{ id: "Sender", category_code: 'Exchange' }]}
  let(:receiver_params) {[{ id: "Receiver", category_code: 'Exchange' }]}

  let(:physical_household_params) do
    [{
      household_size_quantity: 1,
      household_member_references: [{ ref: "a-person-id" }]
    }]
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

  let(:tax_return_params) do
    [{
      total_exemptions_quantity: 1,
      status_code: "0",
      tax_return_year: 2020,
      tax_household: tax_household,
      tax_return_includes_dependent_indicator: true
    }]
  end

  let(:tax_household) do
    {
      household_incomes:
        [{
          monthly_income_greater_than_fpl: true,
          income_type_code: 'CapitalGains',
          income_amount: 500.00,
          income_frequency: { frequency_code: 'Weekly' },
          income_from_tribal_source: 120.00,
          monthly_attested_medicaid_household_current_income: 0.00,
          annual_total_project_medicaid_household_current_income: 0.00
        }]
    }
  end

  context 'invalid parameters' do
    context 'with empty parameters' do
      it 'should list error for every required parameter' do
        expect { described_class.new }.to raise_error(Dry::Struct::Error, /:identification_id is missing in Hash input/)
      end
    end

    context 'with optional parameters only' do
      it 'should list error for every required parameter' do
        expect { described_class.new(optional_params) }.to raise_error(Dry::Struct::Error, /:last_name is missing in Hash input/)
      end
    end
  end

  context 'valid parameters' do
    context 'with required parameters only' do
      it 'should initialize' do
        expect(described_class.new(required_params)).to be_a described_class
      end

      it 'should not raise error' do
        expect { described_class.new(required_params) }.not_to raise_error
      end
    end

    context 'with all required and optional parameters' do
      it 'should initialize' do
        expect(described_class.new(required_params)).to be_a described_class
      end

      it 'should not raise error' do
        expect { described_class.new(required_params) }.not_to raise_error
      end
    end
  end
end
