# frozen_string_literal: true

module AcaEntities
  # Entity for BasisForIncome
  class BasisForIncome < Dry::Struct
    attribute :ssa_citizenship_status, Types::Bool.optional.meta(omittable: true)
  end
end
