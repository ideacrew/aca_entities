# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Contract for Relationship.
      class RelationshipContract < Dry::Validation::Contract

        params do
          required(:kind).filled(:string)
          required(:applicant_reference).filled(:hash)
          required(:relative_reference).filled(:hash)
          optional(:lives_with_household_member).maybe(:bool)
        end

        rule(:applicant_reference) do
          if key? && value
            if value.is_a?(Hash)
              result = ApplicantReferenceContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid applicant_reference.', error: result.errors.to_h)
              else
                values.merge!(applicant_reference: result.to_h)
              end
            else
              key.failure(text: 'invalid applicant_reference. Expected a hash.')
            end
          end
        end

        rule(:relative_reference) do
          if key? && value
            if value.is_a?(Hash)
              result = ApplicantReferenceContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid relative_reference.', error: result.errors.to_h)
              else
                values.merge!(relative_reference: result.to_h)
              end
            else
              key.failure(text: 'invalid relative_reference. Expected a hash.')
            end
          end
        end
      end
    end
  end
end
