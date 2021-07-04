# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Entity for CurrentIncomeRequestPayloadType
        class CurrentIncomeRequestPayloadType < Dry::Struct

          attribute :person,  Types::Array.of(Fdsh::Ridp::H139::PersonType).optional.meta(omittable: false)
        end
      end
    end
  end
end