# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      # Entity for h36 PersonAddressGroup
      class PersonAddressGroup < Dry::Struct
        attribute :UsAddressGroup,  AcaEntities::Fdsh::H36::UsAddressGroup.meta(omittable: false)
      end
    end
  end
end
