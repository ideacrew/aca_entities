# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Verifications
        # contract for curam verifications
        class VerificationContract < Curam::ApplicationContract
          params do
            required(:lawful_presence).filled(:hash)
            required(:residency).filled(:hash)
          end

          rule(:lawful_presence) do
            if key? && value
              if value.is_a?(Hash)
                result = Verifications::LawfulPresenceContract.new.call(value)
                if result&.failure?
                  key.failure(text: 'invalid lawful_presence', error: result.errors.to_h)
                else
                  values.merge!(lawful_presence: result.to_h)
                end
              else
                key.failure(text: 'invalid lawful_presence. Expected a hash.')
              end
            end
          end

          rule(:residency) do
            if key? && value
              if value.is_a?(Hash)
                result = Verifications::ResidencyContract.new.call(value)
                if result&.failure?
                  key.failure(text: 'invalid residency', error: result.errors.to_h)
                else
                  values.merge!(residency: result.to_h)
                end
              else
                key.failure(text: 'invalid residency. Expected a hash.')
              end
            end
          end
        end
      end
    end
  end
end
