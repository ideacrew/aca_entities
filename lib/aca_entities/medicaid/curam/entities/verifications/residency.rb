# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Verifications
        # entity for residency Verification
        class Residency < Dry::Struct

          attribute :residency_status,  Types::ResidencyStatusKind.meta(omittable: false)
        end
      end
    end
  end
end