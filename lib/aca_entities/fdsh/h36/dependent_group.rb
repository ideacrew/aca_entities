# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      # Entity for h36 entity DependentGroup
      class DependentGroup < Dry::Struct
        attribute :DependentPerson, AcaEntities::Fdsh::H36::DependentPerson.meta(omittable: false)
      end
    end
  end
end
