# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Types do
  # checks if string adheres to a 8-4-4-4-12 format
  describe 'CorrelationId' do
    let(:uuid_regex) { /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/ }
    it 'should generate a random v4 Universally Unique IDentifier (UUID)' do
      expect(AcaEntities::Types::CorrelationId).to match uuid_regex
    end
  end

  describe 'EmailAddressKind' do
    let(:valid_emails) { %w[info@example.com info@example.com info@example.com] }
    let(:invalid_emails) { %w[blah @nonsense nodomain@ badc!rs@example.com] }

    it 'valid email addresses should pass validation' do
      valid_emails.each { |email| expect(AcaEntities::Types::EmailAddressKind.valid?(email)).to be_truthy }
    end

    it 'invalid email addresses should fail validation' do
      invalid_emails.each { |email| expect(AcaEntities::Types::EmailAddressKind.valid?(email)).to be_falsey }
    end
  end

  describe 'PhoneNumberKind' do
    let(:valid_phones) { ['202-555-1212', '2025551212', '202-555-1212', '(202) 555-1212', '202.555.1212'] }
    let(:invalid_phones) { ['202-55-1212', '+1 20255551212', '12025551212'] }

    it 'valid phone numbers should pass validation' do
      valid_phones.each { |phone| expect(AcaEntities::Types::PhoneNumberKind.valid?(phone)).to be_truthy }
    end

    it 'invalid phone numbers should fail validation' do
      invalid_phones.each { |phone| expect(AcaEntities::Types::PhoneNumberKind.valid?(phone)).to be_falsey }
    end
  end

  describe 'ZipcodeKind' do
    let(:valid_zipcodes) { %w[04260 04260-2345] }
    let(:invalid_zipcodes) { %w[4260 04620-123 04620-12345] }

    it 'valid phone numbers should pass validation' do
      valid_zipcodes.each { |zipcode| expect(AcaEntities::Types::ZipcodeKind.valid?(zipcode)).to be_truthy }
    end

    it 'invalid zipcode numbers should fail validation' do
      invalid_zipcodes.each { |zipcode| expect(AcaEntities::Types::ZipcodeKind.valid?(zipcode)).to be_falsey }
    end
  end

  describe 'UriKind' do
    let(:valid_uri) { 'https://example.com/api/v1/whazzup' }
    let(:invalid_uri) { 'just a regular string' }

    it 'a valid URI should pass validation' do
      expect(AcaEntities::Types::UriKind.valid?(valid_uri)).to be_truthy
    end

    it 'an invalid URI should fail validation' do
      expect { AcaEntities::Types::UriKind.valid?(invalid_uri) }.to raise_error URI::InvalidURIError
    end
  end
end
