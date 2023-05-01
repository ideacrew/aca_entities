# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      # Entity for h36 entity DependentPerson
      class DependentPerson < Dry::Struct
        attribute :CompletePersonName, AcaEntities::Fdsh::H36::CompletePersonName.meta(omittable: false)
        attribute :SSN, AcaEntities::Types::String.optional.meta(omittable: true)
        attribute :BirthDt, AcaEntities::Types::Date.optional.meta(omittable: true)
      end
    end
  end
end
