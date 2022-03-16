# frozen_string_literal: true

require 'spec_helper'
require 'bigdecimal'
require 'bigdecimal/util'

RSpec.describe AcaEntities::Ledger::Customer do
  subject { described_class }

  context 'Customer components' do
    let(:id) { 12_345 }

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
    let(:amount) { 875.22.to_d }
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
    let(:tax_household) do
      { assistance_year: moment.year, exchange_assigned_id: '898989', aptc_amount: 585.69.to_d, start_on: start_on }
    end
    let(:tax_households) { [tax_household] }

    let(:is_active) { true }

    let(:moment) { DateTime.now }
    let(:timestamps) { { created_at: moment, modified_at: moment } }

    let(:insurance_coverage) do
      { tax_households: tax_households, policies: policies, is_active: is_active, hbx_id: hbx_id }
    end

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

    describe 'with required arguments' do
      it 'should initialize' do
        expect(subject.new(required_params)).to be_a described_class
      end
    end

    describe 'Applying Comparable methods' do
      context 'and comparing two customers with same attributes' do
        let(:customer_1) { all_params }
        let(:customer_2) { all_params }

        it 'they should be equal' do
          expect(subject.new(customer_1)).to eq subject.new(customer_2)
        end
      end

      context 'and comparing two customers, one with different is_active value' do
        let(:customer_1) { all_params }
        let(:customer_2) { all_params.merge(is_active: false) }

        it 'they should not be equal' do
          expect(subject.new(customer_1)).not_to eq subject.new(customer_2)
        end
      end
    end
  end
end
