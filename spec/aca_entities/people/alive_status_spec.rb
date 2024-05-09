# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::People::AliveStatus, dbclean: :after_each do

  let(:alive_status_params) { { is_deceased: false, date_of_death: nil } }

  describe 'with valid arguments' do

    it 'should initialize' do
      expect(described_class.new(alive_status_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(alive_status_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect do
        described_class.new(alive_status_params.merge(date_of_death: 'Testing with invalid value.'))
      end.to raise_error(Dry::Struct::Error, /has invalid type for :date_of_death violates constraints/)
    end
  end
end
