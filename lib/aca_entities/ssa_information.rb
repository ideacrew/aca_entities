# frozen_string_literal: true

module AcaEntities
  # Entity for SsaInformation.
  class SsaInformation < Dry::Struct

    # Default is true unless SSA confirms that the individual is deceased.
    attribute :is_person_alive,    Types::Bool.optional.meta(omittable: true)
  end
end
