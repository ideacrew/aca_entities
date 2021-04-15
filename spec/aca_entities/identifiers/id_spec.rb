# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Identifiers::Id, dbclean: :after_each do

  let!(:input_params) do
    {
      key: :curam_e_case_id,
      item: '123',
      kind: {
        key: :e_case,
        namespace: 'curam',
        label: 'Curam Case Id',
        description: 'test'
      },
      start_on: Date.today,
      end_on: Date.today.next_month
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
      expect { described_class.new(input_params.reject { |k, _v| k == :key }) }.to raise_error(Dry::Struct::Error, /:key is missing/)
    end
  end
end


