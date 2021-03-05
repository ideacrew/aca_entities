# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/email'

RSpec.describe ::AcaEntities::Email, dbclean: :after_each do

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
end
