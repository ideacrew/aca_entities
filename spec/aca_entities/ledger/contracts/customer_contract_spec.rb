# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Ledger::Contracts::CustomerContract do
  subject { described_class.new }

  context 'Customer components' do
    let(:id) { '12345' }

    # Customer
    let(:hbx_id) { '1138345' }
    let(:first_name) { 'George' }
    let(:last_name) { 'Jetson' }
    let(:customer_role) { 'subscriber' }

    # Account
    let(:number) { '1100001'.to_i }
    let(:name) { 'Accounts Receivable' }
    let(:account_kind) { 'asset' }
    let(:account) { { number: number, name: name, kind: account_kind } }

    # Member
    let(:subscriber_hbx_id) { hbx_id }
    let(:person_name) { { first_name: first_name, last_name: first_name } }
    let(:member) { { hbx_id: hbx_id, subscriber_hbx_id: subscriber_hbx_id, person_name: person_name } }

    # Product
    let(:hbx_qhp_id) { '96667ME031005806' }
    let(:effective_year) { 2022 }
    let(:kind) { 'health' }
    let(:product) { { hbx_qhp_id: hbx_qhp_id, effective_year: effective_year, kind: kind } }

    # Premium
    let(:insured_age) { 33 }
    let(:amount) { 875.22 }
    let(:premium) { { insured_age: insured_age, amount: amount } }

    # Enrolled Member
    let(:start_on) { Date.new(2022, 2, 1) }
    let(:enrolled_member) { { member: member, premium: premium, start_on: start_on } }
    let(:enrolled_members) { [enrolled_member] }

    # Insurer
    let(:hios_id) { '96667' }
    let(:insurer) { { hios_id: hios_id } }

    # Policy
    let(:exchange_assigned_id) { '68576' }
    let(:rating_area_id) { 'R-ME001' }
    let(:policy) do
      {
        exchange_assigned_id: exchange_assigned_id,
        marketplace_segments: marketplace_segments,
        subscriber_hbx_id: subscriber_hbx_id,
        insurer: insurer,
        product: product,
        rating_area_id: rating_area_id,
        start_on: start_on
      }
    end
    let(:policies) { [policy] }

    # Marketplace Segment
    let(:policy_id) { '68576' }
    let(:segment) { [subscriber_hbx_id, policy_id, start_on.strftime('%Y%m%d')].join('-') }
    let(:marketplace_segment) do
      {
        subscriber_hbx_id: subscriber_hbx_id,
        start_on: start_on,
        segment: segment,
        enrolled_members: enrolled_members,
        total_premium_amount: amount,
        total_premium_responsibility_amount: amount
      }
    end
    let(:marketplace_segments) { [marketplace_segment] }

    # Tax Household
    let(:tax_household) { { aptc_amount: 585.69 } }
    let(:tax_households) { [tax_household] }

    let(:is_active) { true }

    let(:moment) { DateTime.now }
    let(:timestamps) { { created_at: moment, modified_at: moment } }

    let(:insurance_coverage) { { tax_households: tax_households, policies: policies, is_active: is_active } }

    let(:required_params) do
      {
        hbx_id: hbx_id,
        first_name: first_name,
        last_name: last_name,
        customer_role: customer_role,
        account: account,
        insurance_coverage: insurance_coverage,
        is_active: is_active
      }
    end
    let(:optional_params) { { id: id, timestamps: timestamps } }
    let(:all_params) { required_params.merge(optional_params) }

    context 'Calling contract with Valid params' do
      context 'Calling the contract with required params' do
        it 'should pass validation' do
          result = subject.call(required_params)
          expect(result.success?).to be_truthy
          expect(result.to_h).to eq required_params
        end
      end

      context 'Calling the contract with all params' do
        it 'should pass validation' do
          result = subject.call(all_params)
          expect(result.success?).to be_truthy
          expect(result.to_h).to eq all_params
        end
      end
    end

    context 'Calling the contract with no params' do
      let(:error_message) do
        {
          hbx_id: ['is missing'],
          first_name: ['is missing'],
          last_name: ['is missing'],
          account: ['is missing'],
          is_active: ['is missing'],
          customer_role: ['is missing'],
          insurance_coverage: ['is missing']
        }
      end
      it 'should pass validation' do
        result = subject.call({})
        expect(result.failure?).to be_truthy
        expect(result.errors.to_h).to eq error_message
      end
    end
  end

  context 'Customer transaction' do
    let(:transaction) do
      {
        # customer_id: '1055668',
        hbx_id: '1055668',
        last_name: 'Jetson',
        first_name: 'George',
        customer_role: 'subscriber',
        is_active: true,
        account: {
          number: '1100001'.to_i,
          name: 'Accounts Receivable',
          kind: 'asset',
          is_active: true
        },
        insurance_coverage: {
          tax_households: [{ id: '100', aptc_amount: 850.0, csr: 0, start_on: '20220101', end_on: '20221231' }],
          policies: [
            {
              exchange_assigned_id: '50836',
              insurer_assigned_id: 'HP5977620',
              rating_area_id: 'R-ME003',
              subscriber_hbx_id: '1055668',
              start_on: '20220101',
              end_on: '20221231',
              insurer: {
                hios_id: '96667'
              },
              product: {
                hbx_qhp_id: '96667ME031005806',
                effective_year: 2022,
                kind: 'health'
              },
              marketplace_segments: [
                {
                  segment: '1055668-50836-20220101',
                  total_premium_amount: 1104.58,
                  total_premium_responsibility_amount: 254.58,
                  start_on: '20220101',
                  enrolled_members: [
                    {
                      member: {
                        relationship_code: '1:18',
                        is_subscriber: true,
                        subscriber_hbx_id: '1055668',
                        hbx_id: '1055668',
                        insurer_assigned_id: 'HP597762000',
                        insurer_assigned_subscriber_id: 'HP597762000',
                        person_name: {
                          last_name: 'Jetson',
                          first_name: 'George'
                        },
                        ssn: '012859874',
                        dob: '19781219',
                        gender: 'male',
                        tax_household_id: '100'
                      },
                      premium: {
                        amount: 423.86
                      },
                      start_on: '20220101',
                      end_on: '20221231'
                    },
                    {
                      member: {
                        relationship_code: '4:19',
                        is_subscriber: false,
                        subscriber_hbx_id: '1055668',
                        hbx_id: '1055678',
                        insurer_assigned_id: 'HP597762002',
                        insurer_assigned_subscriber_id: 'HP597762000',
                        person_name: {
                          last_name: 'Jetson',
                          first_name: 'Jane'
                        },
                        ssn: '012859875',
                        dob: '19830906',
                        gender: 'female',
                        tax_household_id: '100'
                      },
                      premium: {
                        amount: 410.06
                      },
                      start_on: '20220101',
                      end_on: '20221231'
                    },
                    {
                      member: {
                        relationship_code: '2:01',
                        is_subscriber: false,
                        subscriber_hbx_id: '1055668',
                        hbx_id: '1055689',
                        insurer_assigned_id: 'HP597762001',
                        insurer_assigned_subscriber_id: 'HP597762000',
                        person_name: {
                          last_name: 'Jetson',
                          first_name: 'Judy'
                        },
                        ssn: '012859876',
                        dob: '20070215',
                        gender: 'female',
                        tax_household_id: '100',
                        emails: 'jetsons@example.com'
                      },
                      premium: {
                        amount: 270.66
                      },
                      start_on: '20220101',
                      end_on: '20221231'
                    }
                  ]
                }
              ]
            }
          ],
          is_active: true
        }
      }
    end
    context 'Calling the contract with transaction params' do
      it 'should pass validation' do
        result = subject.call(transaction)
        expect(result.success?).to be_truthy
      end
    end
  end
end
