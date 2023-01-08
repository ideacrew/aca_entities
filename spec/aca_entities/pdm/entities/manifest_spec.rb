# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Pdm::Entities::Manifest, dbclean: :after_each do

  let(:required_params) do
    {
      type: "pvc_manifest_type",
      assistance_year: 2023
    }
  end

  let(:invalid_params) do
    {
      type: "this_is_the_type"
    }
  end

  let(:optiona_params) do
    {
      batch_id: "batch_id",
      name: "name",
      timestamp: Date.today,
      response: "response",
      count: 1
    }
  end

  describe 'with valid arguments' do

    it 'should initialize' do
      expect(described_class.new(required_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(required_params) }.not_to raise_error
    end

    it 'should not raise error with optional params' do
      expect { described_class.new(required_params.merge(optiona_params)) }.not_to raise_error
    end

  end

  describe 'with invalid arguments' do

    it 'should raise error' do
      expect do
        described_class.new(invalid_params)
      end.to raise_error(Dry::Struct::Error)
    end
  end
end


