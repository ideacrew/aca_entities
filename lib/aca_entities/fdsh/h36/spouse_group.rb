# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      # Entity for h36 entity SpouseGroup
      class SpouseGroup < Dry::Struct
        attribute :Spouse, AcaEntities::Fdsh::H36::Spouse.meta(omittable: false)
      end
    end
  end
end
