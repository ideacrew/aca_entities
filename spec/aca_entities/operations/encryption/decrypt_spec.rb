# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/operations/encryption/encrypt'
require 'aca_entities/operations/encryption/decrypt'

RSpec.describe AcaEntities::Operations::Encryption::Decrypt do

  subject { described_class.new.call(input) }

  context 'Given a value encrypted with the corresponding encryption operation' do

    let(:encrypted_value) {AcaEntities::Operations::Encryption::Encrypt.new.call({ value: "Hello World" }).value! }
    let(:input) { { value: encrypted_value } }

    it 'can decrypt correctly' do
      expect(subject).to be_a Dry::Monads::Result::Success
      expect(subject.value!).to eq "Hello World"
    end
  end

  context 'Given a legacy encrypted value' do
    let(:encrypted_value) do
      key = AcaEntities::Encryption::Symmetric::LegacyKeyset.secret_key
      iv = AcaEntities::Encryption::Symmetric::LegacyKeyset.iv
      box = RbNaCl::SecretBox.new(key)
      Base64.encode64(box.encrypt(iv, "Hello World"))
    end
    let(:input) { { value: encrypted_value } }

    it 'can decrypt correctly' do
      expect(subject).to be_a Dry::Monads::Result::Success
      expect(subject.value!).to eq "Hello World"
    end
  end
end