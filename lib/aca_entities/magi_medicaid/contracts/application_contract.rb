# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Contract for Application.
      class ApplicationContract < Dry::Validation::Contract

        params do
          required(:family_reference).filled(:hash)
          required(:assistance_year).filled(:integer)
          optional(:years_to_renew).maybe(:integer)
          optional(:renewal_consent_through_year).maybe(:integer)
          optional(:is_ridp_verified).maybe(:bool)
          optional(:is_renewal_authorized).maybe(:bool)
          required(:applicants).array(:hash)
        end

        # rule(:family_reference) do
        #   if key? && value
        #     if value.is_a?(Hash)
        #       result = AcaEntities::Contracts::References::FamilyContract.new.call(value)
        #       if result&.failure?
        #         key.failure(text: 'invalid family_reference', error: result.errors.to_h)
        #       else
        #         values.merge!(family_reference: result.to_h)
        #       end
        #     else
        #       key.failure(text: 'invalid family_reference. Expected a hash.')
        #     end
        #   end
        # end

        # rule(:years_to_renew, :renewal_consent_through_year, :is_renewal_authorized) do
        #   if values[:is_renewal_authorized] && !(values[:years_to_renew] || values[:renewal_consent_through_year])
        #     key.failure('at least one must be provided')
        #   end
        # end

        rule(:applicants).each do  |key, value|
          if key? && value
            if value.is_a?(Hash)
              result = ApplicantContract.new.call(value)
              key.failure(text: "invalid applicant", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid applicant. Expected a hash.")
            end
          end
        end
      end
    end
  end
end
