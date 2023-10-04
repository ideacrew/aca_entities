# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Accounts::Profile do
  let(:preferred_name) { 'John Jacob Jingleheimer-Schmitt' }
  let(:locale) { 'en' }
  let(:notice_delivery_method) { 'electronic_preferred' }
  let(:electronic_communication_method) { 'sms' }
  let(:email) { 'jjj@folksongs.org' }
  let(:mobile_phone) { '2025551212' }

  let(:required_params) do
    {
      preferred_name: preferred_name,
      locale: locale,
      notice_delivery_method: notice_delivery_method,
      electronic_communication_method: electronic_communication_method
    }
  end
  let(:optional_params) { { email: email, mobile_phone: mobile_phone } }

  let(:nil_value_optional_params) { { email: nil, mobile_phone: nil, created_at: nil, updated_at: nil } }
  let(:all_params) { required_params.merge(optional_params) }

  describe 'attributes' do
    context 'with required params' do
      subject(:profile) { described_class.new(required_params) }

      it 'has the expected attributes' do
        expect(profile.to_h).to eq required_params
      end
    end

    context 'with all params' do
      subject(:profile) { described_class.new(all_params) }

      it 'has the expected attributes' do
        expect(profile.to_h).to eq all_params
      end
    end

    context 'with optional params that have nil values' do
      subject(:profile) { described_class.new(all_params.merge(nil_value_optional_params)) }

      it 'has the expected attributes' do
        expect(profile.to_h).to eq all_params.merge(nil_value_optional_params)
      end
    end
  end

  describe '#initials' do
    subject(:profile) { described_class.new(all_params) }
    let(:jjj_initals) { 'JJJ' }

    it 'returns expected value for initials' do
      expect(profile.initials).to eq jjj_initals
    end
  end
end
