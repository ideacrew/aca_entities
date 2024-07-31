# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Contacts::EmailContact do

  describe 'with valid arguments' do
    let(:input_params) do
      { kind: 'home', address: 'yy@ll.com' }
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
      expect { described_class.new(kind: 100) }.to raise_error(Dry::Struct::Error, /invalid type for :kind violates constraints/)
    end
  end
end
