# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for HouseholdComposition
      class HouseholdComposition < Dry::Struct
        attribute :medicaid_household_size,  Types::Integer.optional.meta(omittable: true)
        attribute :qualified_children_list,  Types::String.optional.meta(omittable: true)
      end
    end
  end
end
