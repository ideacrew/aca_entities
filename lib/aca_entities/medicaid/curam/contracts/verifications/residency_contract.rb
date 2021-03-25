# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Verifications
        # contract for curam residency verification
        class ResidencyContract < Curam::ApplicationContract
          params do
            required(:residency_status).filled(:string)
          end

          rule(:residency_status) do
            key.failure(text: 'invalid residency_status') if key? && value && !Types::ResidencyStatusKind.include?(value)
          end
        end
      end
    end
  end
end
