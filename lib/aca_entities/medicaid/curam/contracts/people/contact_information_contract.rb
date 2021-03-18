# frozen_string_literal: true

module Ehs
  class People::ContactInformationContract < Ehs::ApplicationContract

    params do
      required(:addresses).array(:hash)
      required(:phones).array(:hash)
      optional(:emails).array(:hash)
    end

    rule(:addresses) do
      if key? && value
        addresses_array = value.inject([]) do |hash_array, address_hash|
                            if address_hash.is_a?(Hash)
                              result = Addresses::AddressContract.new.call(address_hash)
                              if result&.failure?
                                key.failure(text: 'invalid address', error: result.errors.to_h)
                              else
                                hash_array << result.to_h
                              end
                            else
                              key.failure(text: 'invalid address. Expected a hash.')
                            end
                            hash_array
                          end
        values.merge!(addresses: addresses_array)
      end
    end

    rule(:phones) do
      if key? && value
        phones_array = value.inject([]) do |hash_array, phone_hash|
                            if phone_hash.is_a?(Hash)
                              result = Phones::PhoneContract.new.call(phone_hash)
                              if result&.failure?
                                key.failure(text: 'invalid phone', error: result.errors.to_h)
                              else
                                hash_array << result.to_h
                              end
                            else
                              key.failure(text: 'invalid phone. Expected a hash.')
                            end
                            hash_array
                          end
        values.merge!(phones: phones_array)
      end
    end

    rule(:emails) do
      if key? && value
        emails_array = value.inject([]) do |hash_array, email_hash|
                            if email_hash.is_a?(Hash)
                              result = Emails::EmailContract.new.call(email_hash)
                              if result&.failure?
                                key.failure(text: 'invalid email', error: result.errors.to_h)
                              else
                                hash_array << result.to_h
                              end
                            else
                              key.failure(text: 'invalid email. Expected a hash.')
                            end
                            hash_array
                          end
        values.merge!(emails: emails_array)
      end
    end
  end
end
