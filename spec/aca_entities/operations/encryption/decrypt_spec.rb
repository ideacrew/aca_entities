# frozen_string_literal: true

require 'spec_helper'
RSpec.describe AcaEntities::Operations::Encryption::Decrypt do

  subject { described_class.new.call(input) }

  context 'When any type of value is passed' do

    let(:encrypted_value) {AcaEntities::Operations::Encryption::Encrypt.new.call({ value: "Hello World" }).value! }
    let(:input) { { value: encrypted_value } }

    it 'should return success with decrypted value' do
      expect(subject).to be_a Dry::Monads::Result::Success
      expect(subject.value!).to eq "Hello World"
    end
  end
end