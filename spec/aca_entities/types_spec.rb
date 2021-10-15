# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Types do
  describe 'EmailAddressKind' do
    let(:valid_emails) do
      %w[info@example.com info@example.com info@example.com]
    end

    let(:invalid_emails) { %w[blah @nonsense nodomain@ badc!rs@example.com] }

    it 'valid email addresses should validate' do
      valid_emails.each do |email|
        expect(AcaEntities::Types::EmailAddressKind.valid?(email)).to be_truthy
      end
    end

    it 'invalid email addresses should fail validation' do
      invalid_emails.each do |email|
        expect(AcaEntities::Types::EmailAddressKind.valid?(email)).to be_falsey
      end
    end
  end
end
