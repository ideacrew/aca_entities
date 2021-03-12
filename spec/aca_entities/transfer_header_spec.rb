# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/transfer_header'

RSpec.describe ::AcaEntities::TransferHeader do

  describe 'with valid arguments' do
    let(:input_params) do
      {
        transfer_id: 'id',
        transfer_date: Date.today.to_datetime,
        number_of_referrals: 4,
        recipient_code: 'code',
        medicaid_chip_state: 'MA'
      }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end

    context 'invalid input for transfer_date' do
      let(:output) { described_class.new(input_params.merge(transfer_date: Date.today.to_date)) }
      it 'should return error message' do
        expect { output }.to raise_error(Dry::Struct::Error, /has invalid type for :transfer_date/)
      end
    end
  end
end
