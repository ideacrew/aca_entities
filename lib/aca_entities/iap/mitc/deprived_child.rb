# frozen_string_literal: true

module AcaEntities
  module Iap
    module Mitc
      class DeprivedChild < Dry::Struct

        # @!attribute [r] qualify_as_deprived_child
        # Does the person qualify as a Deprived Child?
        # @return [Integer]
        attribute :qualify_as_deprived_child, Types::YesNoKind.meta(ommittable: false)
      end
    end
  end
end
