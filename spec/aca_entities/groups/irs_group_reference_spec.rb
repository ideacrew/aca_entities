# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Groups::IrsGroupReference, dbclean: :after_each do

  let!(:input_params) do
    {
      hbx_id: "1233"
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
      expect { described_class.new(input_params.reject { |k, _v| k == :hbx_id }) }.to raise_error(Dry::Struct::Error, /:hbx_id is missing/)
    end
  end
end


