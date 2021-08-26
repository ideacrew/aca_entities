# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp AuthorizedRepresentativeReference
      class AuthorizedRepresentativeReference < Dry::Struct
        attribute :ref, Types::String.meta(omittable: false)
      end
    end
  end
end