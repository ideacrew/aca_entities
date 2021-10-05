# frozen_string_literal: true

require 'spec_helper'
RSpec.describe AcaEntities::Operations::Encryption::Encrypt do
  subject { described_class.new.call(input) }

  context 'When any type of value is passed' do

    let(:encrypted_value) {AcaEntities::Operations::Encryption::Encrypt.new.call({ value: "Hello World" }).value! }
    let(:decryption_operation) { AcaEntities::Operations::Encryption::Decrypt.new }
    let(:input) { { value: "Hello World" } }

    it 'should return success with encrypted value' do
      expect(subject).to be_a Dry::Monads::Result::Success
      result = decryption_operation.call({value: subject.value!} )
      expect(result.value!).to eq "Hello World"
    end
  end
end