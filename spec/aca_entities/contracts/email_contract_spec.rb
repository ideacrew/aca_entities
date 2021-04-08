# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/contracts/email_contract'

RSpec.describe ::AcaEntities::Contracts::EmailContract,  dbclean: :after_each do

  subject do
    described_class.new.call(params)
  end

  describe 'missing address and kind field' do

    let(:params) do
      {}
    end
    let(:error_message) { { :kind => ['is missing'], :address => ['is missing'] } }

    it "fails" do
      expect(subject).not_to be_success
      expect(subject.errors.to_h).to eq error_message
    end
  end

  describe 'passing empty address and kind fields' do

    let(:params) do
      { kind: '', address: '' }
    end
    let(:error_message) { { :address => ['must be filled'], :kind => ['must be filled'] } }

    it 'fails' do
      expect(subject).not_to be_success
      expect(subject.errors.to_h).to eq error_message
    end
  end

  describe 'passing valid address and kind fields' do

    let(:params) do
      { kind: 'home', address: 'test@oo.com' }
    end

    it 'passes' do
      expect(subject).to be_success
    end
  end
end
