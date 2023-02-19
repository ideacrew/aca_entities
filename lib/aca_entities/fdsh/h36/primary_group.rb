# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      # Entity for h36 entity PrimaryGroup
      class PrimaryGroup < Dry::Struct
        attribute :Primary, AcaEntities::Fdsh::H36::Primary.meta(omittable: false)
      end
    end
  end
end
