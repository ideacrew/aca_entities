# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for ApplicantRole.
    class ApplicantRoleContract < Dry::Validation::Contract

      params do
        required(:first_name).filled(:string)
        optional(:middle_name).maybe(:string)
        required(:last_name).filled(:string)
        optional(:name_sfx).maybe(:string)
        optional(:name_pfx).maybe(:string)
        required(:dob).filled(:date)
        required(:gender).maybe(:string)
        optional(:is_veteran_or_active_military).maybe(:bool)
        optional(:age_of_applicant).maybe(:integer)
        optional(:ssn).maybe(:string)
        required(:citizen_status).filled(Iap::Types::CitizenKinds)
        optional(:is_resident_post_092296).maybe(:bool)
        optional(:is_student).maybe(:bool)

        optional(:addresses).maybe(:array)

        optional(:is_incarcerated).maybe(:bool)
        optional(:is_disabled).filled(:bool)
        optional(:ethnicity).maybe(:array)
        optional(:race).maybe(:string)
        optional(:tribal_id).maybe(:string)
      end

      rule(:addresses) do
        if key? && value
          key.failure(text: 'Home address is required.') if required_home_address?(value)
          addresses_array = value.inject([]) do |hash_array, household_hash|
            if household_hash.is_a?(Hash)
              result = AddressContract.new.call(household_hash)
              if result&.failure?
                key.failure(text: 'invalid physical household.', error: result.errors.to_h)
              else
                hash_array << result.to_h
              end
            else
              key.failure(text: 'invalid physical household. Expected a hash.')
            end
            hash_array
          end
          values.merge!(addresses: addresses_array)
        end
      end

      def required_home_address?(address_hashes)
        return false unless any_fixed_address?(address_hashes)
        address_hashes.none? { |address_hash| address_hash[:kind].downcase == 'home' }
      end

      def any_fixed_address?(address_hashes)
        address_hashes.any? { |address_hash| address_hash[:has_fixed_address] == true }
      end
    end
  end
end
