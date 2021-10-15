# frozen_string_literal: true

require 'spec_helper'
RSpec.describe AcaEntities::Operations::Encryption::Encrypt do
  subject { described_class.new.call(input) }

  context 'When any type of value is passed' do

    let(:input) { { value: "Hello world" } }

    it 'should return success with encrypted value' do
      expect(subject).to be_a Dry::Monads::Result::Success
      expect(subject.value!).to be_a String
    end
  end
end