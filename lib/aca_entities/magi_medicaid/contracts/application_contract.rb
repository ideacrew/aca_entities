# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::Application}
      class ApplicationContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Hash] :family_reference required
        # @option opts [Integer] :assistance_year required
        # @option opts [Integer] :years_to_renew optional
        # @option opts [Integer] :renewal_consent_through_year optional
        # @option opts [Boolean] :is_ridp_verified optional
        # @option opts [Boolean] :is_renewal_authorized optional
        # @option opts [Array] :applicants required
        # @return [Dry::Monads::Result]
        params do
          required(:family_reference).filled(:hash) # AcaEntities::Contracts::References::FamilyContract.params
          required(:assistance_year).filled(:integer)
          optional(:years_to_renew).maybe(:integer)
          optional(:renewal_consent_through_year).maybe(:integer)
          optional(:is_ridp_verified).maybe(:bool)
          optional(:is_renewal_authorized).maybe(:bool)
          required(:applicants).array(ApplicantContract.params)
        end

        # rule(:years_to_renew, :renewal_consent_through_year, :is_renewal_authorized) do
        #   if values[:is_renewal_authorized] && !(values[:years_to_renew] || values[:renewal_consent_through_year])
        #     key.failure('at least one must be provided')
        #   end
        # end

        rule(:applicants) do
          if key? && value
            applicants_array = value.inject([]) do |hash_array, object_hash|
              if object_hash.is_a?(Hash)
                result = ApplicantContract.new.call(object_hash)
                if result&.failure?
                  key.failure(text: 'invalid applicant', error: result.errors.to_h)
                else
                  hash_array << result.to_h
                end
              else
                key.failure(text: 'invalid applicant. Expected a hash.')
              end
              hash_array
            end
            values.merge!(applicants: applicants_array)
          end
        end
      end
    end
  end
end
