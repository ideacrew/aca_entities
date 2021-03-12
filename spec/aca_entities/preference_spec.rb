# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/preference'

RSpec.describe ::AcaEntities::Preference, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:input_params) do
      { spoken_language: 'English',
        written_language: '',
        contact_preference_Code: 'TextMessage' }
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
      expect { subject }.to raise_error(Dry::Struct::Error, /:spoken_language is missing in Hash input/)
    end
  end
end
