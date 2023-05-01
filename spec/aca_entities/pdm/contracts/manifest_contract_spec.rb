# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Pdm::Contracts::ManifestContract, dbclean: :after_each do
  let(:valid_params) do
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

  let(:optional_params) do
    {
      batch_ids: ["123", "456"],
      initial_count: 10,
      generated_count: 10,
      file_generated: true
    }
  end

  describe 'with valid arguments' do

    it 'should return success' do
      expect(subject.call(valid_params)).to be_truthy
    end

    it 'should return success with optional params' do
      expect(subject.call(valid_params.merge(optional_params))).to be_truthy
    end

  end

  describe 'with invalid arguments' do

    it 'should be a failure with invalid params' do
      expect(subject.call(invalid_params).failure?).to be_truthy
    end

  end
end
