# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Accounts::Oauth::Extra do
  let(:raw_info) { {} }

  let(:required_params) { {} }
  let(:optional_params) { { raw_info: raw_info } }

  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling the contract with only optional params' do
    subject { described_class.call(optional_params) }

    it 'should pass validation' do
      expect(subject).to be_a described_class
      expect(subject.to_h).to eq optional_params
    end
  end

  context 'Calling the contract with required params' do
    subject { described_class.call(required_params) }

    it 'should pass validation' do
      expect(subject).to be_a described_class
      expect(subject.to_h).to eq required_params
    end
  end

  context 'Calling the contract with all params' do
    subject { described_class.call(all_params) }

    it 'should pass validation' do
      expect(subject).to be_a described_class
      expect(subject.to_h).to eq all_params
    end
  end

  context 'Calling the contract with Email key an nil value' do
    subject { described_class.call(all_params.merge(email: nil)) }

    it 'should pass validation' do
      expect(subject).to be_a described_class
      expect(subject.to_h).to eq all_params.merge(email: nil)
    end
  end
end
