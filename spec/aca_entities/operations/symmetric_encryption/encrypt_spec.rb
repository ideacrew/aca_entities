# frozen_string_literal: true

require 'spec_helper'
RSpec.describe AcaEntities::Operations::SymmetricEncryption::Encrypt do
  subject { described_class.new.call(input) }

  context 'When any type of value is passed' do

    let(:encrypted_value) {AcaEntities::Operations::SymmetricEncryption::Encrypt.new.call({ value: "Hello World" }).value! }
    let(:input) { { value: "Hello World" } }

    xit 'should return success with encrypted value' do
      expect(subject).to be_a Dry::Monads::Result::Success
      expect(subject.value!).to eq encrypted_value
    end
  end
end