# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Verifications
        # contract for curam verifications lawfull present
        class LawfulPresenceContract < Curam::ApplicationContract
          params do
            required(:is_lawfully_present).filled(:bool)
            required(:citizen_status).filled(:string)
          end

          rule(:citizen_status) do
            key.failure(text: 'invalid citizen_status') if key? && value && !Types::CitizenStatusKind.include?(value)
          end
        end
      end
    end
  end
end
