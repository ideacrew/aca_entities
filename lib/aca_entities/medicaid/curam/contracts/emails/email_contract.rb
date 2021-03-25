# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Emails
        # contract for curam email
        class EmailContract < Curam::ApplicationContract

          params do
            required(:type).filled(Curam::TypesEmailKind)
            required(:address).filled(:string)
          end
        end
      end
    end
  end
end
