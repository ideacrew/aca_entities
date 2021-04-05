# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for BasisForIncome
      class BasisForIncome < Dry::Struct
        attribute :ssa_citizenship_status, Types::Bool.optional.meta(omittable: true)
      end
    end
  end
end
