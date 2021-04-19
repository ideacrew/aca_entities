# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Contacts::PhoneContact, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:input_params) do
      { kind: 'home',
        country_code: '1',
        area_code: '100',
        number: '1234567',
        extension: '101',
        primary: true,
        full_phone_number: '1001234567' }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { subject }.to raise_error(Dry::Struct::Error, /:kind is missing in Hash input/)
    end
  end
end
