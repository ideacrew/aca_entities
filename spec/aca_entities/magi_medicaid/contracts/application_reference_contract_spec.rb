# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Contracts::ApplicationReferenceContract,  dbclean: :after_each do

  subject do
    described_class.new.call(params)
  end

  describe 'passing empty values for fields' do
    let(:params) do
      { hbx_id: '' }
    end

    let(:error_message) do
      { hbx_id: ['must be filled'] }
    end

    it 'fails' do
      expect(subject.errors.to_h).to eq error_message
    end
  end

  describe 'passing valid fields' do
    let(:params) do
      { hbx_id: '200' }
    end

    it 'passes' do
      expect(subject).to be_success
    end
  end
end
