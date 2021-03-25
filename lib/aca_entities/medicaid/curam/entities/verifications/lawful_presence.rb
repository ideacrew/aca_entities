# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Verifications
        # entity for Lawful presence Verification
        class LawfulPresence < Dry::Struct

          attribute :is_lawfully_present, Types::Bool.meta(omittable: false)
          attribute :citizen_status,      Types::CitizenStatusKind.meta(omittable: false)
        end
      end
    end
  end
end
