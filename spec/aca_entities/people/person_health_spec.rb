# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::People::PersonHealth, dbclean: :after_each do

  let!(:input_params) do
    {
      is_tobacco_user: 'unknown',
      is_physically_disabled: false
    }
  end

  describe 'with valid arguments' do

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect do
        described_class.new(input_params.merge(is_tobacco_user: 1))
      end.to raise_error(Dry::Struct::Error, /has invalid type for :is_tobacco_user/)
    end
  end
end
